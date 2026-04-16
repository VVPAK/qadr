import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/data/preferences/secure_storage.dart';
import '../../../core/utils/logger.dart';
import '../domain/models/chat_message.dart';
import '../domain/services/llm_service.dart';

class OpenAiLlmService implements LlmService {
  OpenAiLlmService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<({String baseUrl, String apiKey})> _getConfig() async {
    final apiKey = await SecureStorage.getApiKey();
    final baseUrl =
        await SecureStorage.getApiBaseUrl() ?? 'https://api.openai.com/v1';
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API key not configured');
    }
    return (baseUrl: baseUrl, apiKey: apiKey);
  }

  List<Map<String, String>> _messagesToPayload(
    List<ChatMessage> messages,
    String systemPrompt,
  ) {
    return [
      {'role': 'system', 'content': systemPrompt},
      ...messages.map((m) => {
            'role': m.role == MessageRole.user ? 'user' : 'assistant',
            'content': m.content,
          }),
    ];
  }

  @override
  Future<String> sendMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) async {
    final config = await _getConfig();

    final response = await _dio.post(
      '${config.baseUrl}/chat/completions',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${config.apiKey}',
          'Content-Type': 'application/json',
        },
      ),
      data: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': _messagesToPayload(messages, systemPrompt),
        'temperature': 0.7,
        'response_format': {'type': 'json_object'},
      }),
    );

    final data = response.data as Map<String, dynamic>;
    final choices = data['choices'] as List;
    return (choices.first['message']['content'] as String).trim();
  }

  @override
  Stream<String> streamMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) async* {
    final config = await _getConfig();

    final response = await _dio.post(
      '${config.baseUrl}/chat/completions',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${config.apiKey}',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.stream,
      ),
      data: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': _messagesToPayload(messages, systemPrompt),
        'temperature': 0.7,
        'stream': true,
      }),
    );

    final stream = response.data.stream as Stream<List<int>>;
    String buffer = '';

    await for (final chunk in stream) {
      buffer += utf8.decode(chunk);
      final lines = buffer.split('\n');
      buffer = lines.removeLast();

      for (final line in lines) {
        if (!line.startsWith('data: ')) continue;
        final data = line.substring(6).trim();
        if (data == '[DONE]') return;

        try {
          final json = jsonDecode(data) as Map<String, dynamic>;
          final delta = json['choices']?[0]?['delta']?['content'] as String?;
          if (delta != null) yield delta;
        } catch (e) {
          Log.e('SSE parse error', error: e);
        }
      }
    }
  }
}

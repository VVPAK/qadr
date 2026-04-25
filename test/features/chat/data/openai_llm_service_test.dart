import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' hide ResponseType;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/features/chat/data/openai_llm_service.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';

const _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

void _stubSecureStorage({String? apiKey = 'sk-test', String? baseUrl}) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_secureStorageChannel, (call) async {
        if (call.method != 'read') return null;
        final args = (call.arguments as Map).cast<String, dynamic>();
        switch (args['key']) {
          case 'llm_api_key':
            return apiKey;
          case 'llm_api_base_url':
            return baseUrl;
        }
        return null;
      });
}

void _clearSecureStorage() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_secureStorageChannel, null);
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> requests = [];
  final List<String> requestBodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (requestStream != null) {
      final bytes = <int>[];
      await for (final chunk in requestStream) {
        bytes.addAll(chunk);
      }
      requestBodies.add(utf8.decode(bytes));
    } else {
      requestBodies.add('');
    }
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _jsonBody(Object body, {int status = 200}) {
  return ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: {
      'content-type': ['application/json; charset=utf-8'],
    },
  );
}

ResponseBody _sseBody(List<String> chunks) {
  final stream = Stream<Uint8List>.fromIterable(
    chunks.map((c) => Uint8List.fromList(utf8.encode(c))),
  );
  return ResponseBody(
    stream,
    200,
    headers: {
      'content-type': ['text/event-stream'],
    },
  );
}

ChatMessage _userMsg(String content, {String id = 'u1'}) => ChatMessage(
  id: id,
  role: MessageRole.user,
  content: content,
  timestamp: DateTime(2026, 1, 1),
);

ChatMessage _assistantMsg(
  String content, {
  String id = 'a1',
  LlmResponse? llmResponse,
}) => ChatMessage(
  id: id,
  role: MessageRole.assistant,
  content: content,
  timestamp: DateTime(2026, 1, 1),
  llmResponse: llmResponse,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(_clearSecureStorage);

  group('OpenAiLlmService.sendMessage', () {
    test('throws when no API key is configured', () async {
      _stubSecureStorage(apiKey: null);
      final service = OpenAiLlmService();
      expect(
        () => service.sendMessage(messages: const [], systemPrompt: 'sys'),
        throwsA(isA<Exception>()),
      );
    });

    test('throws when API key is empty', () async {
      _stubSecureStorage(apiKey: '');
      final service = OpenAiLlmService();
      expect(
        () => service.sendMessage(messages: const [], systemPrompt: 'sys'),
        throwsA(isA<Exception>()),
      );
    });

    test('uses default openai.com base URL when none is configured', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({
          'choices': [
            {
              'message': {'content': 'ok'},
            },
          ],
        }),
      );
      dio.httpClientAdapter = adapter;

      await OpenAiLlmService(
        dio: dio,
      ).sendMessage(messages: const [], systemPrompt: 'sys');

      expect(adapter.requests, hasLength(1));
      expect(
        adapter.requests.single.uri.toString(),
        'https://api.openai.com/v1/chat/completions',
      );
    });

    test('uses configured base URL override', () async {
      _stubSecureStorage(baseUrl: 'https://proxy.example.com/v1');
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({
          'choices': [
            {
              'message': {'content': 'ok'},
            },
          ],
        }),
      );
      dio.httpClientAdapter = adapter;

      await OpenAiLlmService(
        dio: dio,
      ).sendMessage(messages: const [], systemPrompt: 'sys');

      expect(
        adapter.requests.single.uri.toString(),
        'https://proxy.example.com/v1/chat/completions',
      );
    });

    test('sends Bearer auth header with the stored API key', () async {
      _stubSecureStorage(apiKey: 'sk-super-secret');
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({
          'choices': [
            {
              'message': {'content': 'ok'},
            },
          ],
        }),
      );
      dio.httpClientAdapter = adapter;

      await OpenAiLlmService(
        dio: dio,
      ).sendMessage(messages: const [], systemPrompt: 'sys');

      final req = adapter.requests.single;
      final headers = <String, Object?>{};
      req.headers.forEach((k, v) => headers[k.toLowerCase()] = v);
      expect(headers['authorization'], 'Bearer sk-super-secret');
      expect(
        (headers['content-type'] ?? req.contentType)?.toString(),
        contains('application/json'),
      );
    });

    test('builds correct payload: model, temperature, response_format, system '
        'prompt, and user message', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({
          'choices': [
            {
              'message': {'content': 'ok'},
            },
          ],
        }),
      );
      dio.httpClientAdapter = adapter;

      await OpenAiLlmService(dio: dio).sendMessage(
        messages: [_userMsg('hello there')],
        systemPrompt: 'you are qadr',
      );

      final body =
          jsonDecode(adapter.requestBodies.single) as Map<String, dynamic>;
      expect(body['model'], 'gpt-4o-mini');
      expect(body['temperature'], 0.7);
      expect(body['response_format'], {'type': 'json_object'});

      final messages = (body['messages'] as List).cast<Map<String, dynamic>>();
      expect(messages, hasLength(2));
      expect(messages[0], {'role': 'system', 'content': 'you are qadr'});
      expect(messages[1], {'role': 'user', 'content': 'hello there'});
    });

    test(
      'serializes assistant messages with llmResponse as JSON content',
      () async {
        _stubSecureStorage();
        final dio = Dio();
        final adapter = _FakeAdapter(
          (_) async => _jsonBody({
            'choices': [
              {
                'message': {'content': 'ok'},
              },
            ],
          }),
        );
        dio.httpClientAdapter = adapter;

        final response = LlmResponse(
          intent: ChatIntent.tasbih,
          responseType: ResponseType.component,
          text: 'tap the circle',
          component: ComponentPayload(
            type: 'tasbih',
            data: {'dhikrText': 'SubhanAllah', 'targetCount': 33},
          ),
        );

        await OpenAiLlmService(dio: dio).sendMessage(
          messages: [
            _userMsg('start dhikr', id: '1'),
            _assistantMsg('tap the circle', id: '2', llmResponse: response),
            _userMsg('thanks', id: '3'),
          ],
          systemPrompt: 'sys',
        );

        final body =
            jsonDecode(adapter.requestBodies.single) as Map<String, dynamic>;
        final messages = (body['messages'] as List)
            .cast<Map<String, dynamic>>();

        expect(messages[0]['role'], 'system');
        expect(messages[1], {'role': 'user', 'content': 'start dhikr'});
        expect(messages[2]['role'], 'assistant');

        final assistantJson =
            jsonDecode(messages[2]['content'] as String)
                as Map<String, dynamic>;
        expect(assistantJson['intent'], 'tasbih');
        expect(assistantJson['responseType'], 'component');
        expect(assistantJson['text'], 'tap the circle');
        expect(assistantJson['component'], isA<Map>());
        expect(assistantJson['component']['type'], 'tasbih');
        expect(assistantJson['component']['targetCount'], 33);

        expect(messages[3], {'role': 'user', 'content': 'thanks'});
      },
    );

    test(
      'sends assistant messages without llmResponse as plain text content',
      () async {
        _stubSecureStorage();
        final dio = Dio();
        final adapter = _FakeAdapter(
          (_) async => _jsonBody({
            'choices': [
              {
                'message': {'content': 'ok'},
              },
            ],
          }),
        );
        dio.httpClientAdapter = adapter;

        await OpenAiLlmService(dio: dio).sendMessage(
          messages: [_assistantMsg('raw text')],
          systemPrompt: 'sys',
        );

        final body =
            jsonDecode(adapter.requestBodies.single) as Map<String, dynamic>;
        final messages = (body['messages'] as List)
            .cast<Map<String, dynamic>>();
        expect(messages.last, {'role': 'assistant', 'content': 'raw text'});
      },
    );

    test('returns trimmed content from choices[0].message.content', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({
          'choices': [
            {
              'message': {'content': '   {"intent":"qibla"}\n  '},
            },
          ],
        }),
      );
      dio.httpClientAdapter = adapter;

      final result = await OpenAiLlmService(
        dio: dio,
      ).sendMessage(messages: [_userMsg('qibla?')], systemPrompt: 'sys');
      expect(result, '{"intent":"qibla"}');
    });

    test('propagates DioException on non-2xx status', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _jsonBody({'error': 'unauthorized'}, status: 401),
      );
      dio.httpClientAdapter = adapter;

      expect(
        () => OpenAiLlmService(
          dio: dio,
        ).sendMessage(messages: [_userMsg('hi')], systemPrompt: 'sys'),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('OpenAiLlmService.streamMessage', () {
    test('sets stream=true in the request payload', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter((_) async => _sseBody(['data: [DONE]\n']));
      dio.httpClientAdapter = adapter;

      await OpenAiLlmService(dio: dio)
          .streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys')
          .drain<void>();

      final body =
          jsonDecode(adapter.requestBodies.single) as Map<String, dynamic>;
      expect(body['stream'], true);
      expect(body['response_format'], isNull);
    });

    test('yields delta.content values in order', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _sseBody([
          'data: ${jsonEncode({
            'choices': [
              {
                'delta': {'content': 'Hello '},
              },
            ],
          })}\n',
          'data: ${jsonEncode({
            'choices': [
              {
                'delta': {'content': 'world'},
              },
            ],
          })}\n',
          'data: [DONE]\n',
        ]),
      );
      dio.httpClientAdapter = adapter;

      final chunks = await OpenAiLlmService(
        dio: dio,
      ).streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys').toList();
      expect(chunks, ['Hello ', 'world']);
    });

    test('handles SSE chunks split mid-line via the buffer', () async {
      _stubSecureStorage();
      final dio = Dio();
      final payload = jsonEncode({
        'choices': [
          {
            'delta': {'content': 'Assalam'},
          },
        ],
      });
      // Split payload across two adapter chunks with no trailing newline
      // on the first chunk — the service must hold it in its buffer.
      final full = 'data: $payload\n';
      final cut = full.length ~/ 2;
      final adapter = _FakeAdapter(
        (_) async => _sseBody([
          full.substring(0, cut),
          full.substring(cut),
          'data: [DONE]\n',
        ]),
      );
      dio.httpClientAdapter = adapter;

      final chunks = await OpenAiLlmService(
        dio: dio,
      ).streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys').toList();
      expect(chunks, ['Assalam']);
    });

    test('terminates on [DONE] and ignores anything after it', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _sseBody([
          'data: [DONE]\n',
          'data: ${jsonEncode({
            'choices': [
              {
                'delta': {'content': 'late'},
              },
            ],
          })}\n',
        ]),
      );
      dio.httpClientAdapter = adapter;

      final chunks = await OpenAiLlmService(
        dio: dio,
      ).streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys').toList();
      expect(chunks, isEmpty);
    });

    test('skips non-data: lines and lines with no delta.content', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _sseBody([
          ': keep-alive comment\n',
          'event: ping\n',
          'data: ${jsonEncode({
            'choices': [
              {'delta': {}},
            ],
          })}\n',
          'data: ${jsonEncode({
            'choices': [
              {
                'delta': {'content': 'real'},
              },
            ],
          })}\n',
          'data: [DONE]\n',
        ]),
      );
      dio.httpClientAdapter = adapter;

      final chunks = await OpenAiLlmService(
        dio: dio,
      ).streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys').toList();
      expect(chunks, ['real']);
    });

    test('continues after an unparseable data: line', () async {
      _stubSecureStorage();
      final dio = Dio();
      final adapter = _FakeAdapter(
        (_) async => _sseBody([
          'data: {not json}\n',
          'data: ${jsonEncode({
            'choices': [
              {
                'delta': {'content': 'recovered'},
              },
            ],
          })}\n',
          'data: [DONE]\n',
        ]),
      );
      dio.httpClientAdapter = adapter;

      final chunks = await OpenAiLlmService(
        dio: dio,
      ).streamMessage(messages: [_userMsg('hi')], systemPrompt: 'sys').toList();
      expect(chunks, ['recovered']);
    });
  });
}

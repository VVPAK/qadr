import 'dart:convert';

import '../../../../core/constants/islamic_constants.dart';
import '../../../../core/utils/logger.dart';
import '../models/llm_response.dart';

class IntentParser {
  static LlmResponse? parse(String rawResponse) {
    try {
      final jsonStr = _extractJson(rawResponse);
      if (jsonStr == null) return null;

      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return _parseJson(json);
    } catch (e, st) {
      Log.e('Failed to parse LLM response', error: e, stackTrace: st);
      return null;
    }
  }

  static LlmResponse _parseJson(Map<String, dynamic> json) {
    // Parse intent
    final intentStr = json['intent'] as String? ?? 'generalQuestion';
    final intent =
        ChatIntent.values.where((e) => e.name == intentStr).firstOrNull ??
        ChatIntent.generalQuestion;

    // Parse response type
    final typeStr =
        json['responseType'] as String? ??
        json['response_type'] as String? ??
        'text';
    final responseType = typeStr == 'component'
        ? ResponseType.component
        : ResponseType.text;

    // Parse text
    final text = json['text'] as String?;

    // Parse component (safely)
    ComponentPayload? component;
    final componentJson = json['component'];
    if (componentJson is Map<String, dynamic>) {
      final compType = componentJson['type'] as String?;
      final compData = componentJson['data'];
      if (compType != null && compType.isNotEmpty) {
        final Map<String, dynamic> data;
        if (compData is Map<String, dynamic>) {
          data = compData;
        } else {
          // LLM sometimes puts fields at component level instead of in "data"
          data = Map<String, dynamic>.from(componentJson)..remove('type');
        }
        component = ComponentPayload(type: compType, data: data);
      }
    }

    return LlmResponse(
      intent: intent,
      responseType: responseType,
      text: text,
      component: component,
    );
  }

  static String? _extractJson(String text) {
    if (text.trimLeft().startsWith('{')) {
      return text.trim();
    }

    final codeBlockRegex = RegExp(r'```(?:json)?\s*(\{[\s\S]*?\})\s*```');
    final match = codeBlockRegex.firstMatch(text);
    if (match != null) return match.group(1);

    final jsonRegex = RegExp(r'\{[\s\S]*\}');
    final jsonMatch = jsonRegex.firstMatch(text);
    return jsonMatch?.group(0);
  }

  static LlmResponse fallbackTextResponse(String text) {
    return LlmResponse(
      intent: ChatIntent.generalQuestion,
      responseType: ResponseType.text,
      text: text,
    );
  }
}

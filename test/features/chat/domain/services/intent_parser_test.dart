import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';
import 'package:qadr/features/chat/domain/services/intent_parser.dart';

void main() {
  group('IntentParser.parse', () {
    group('JSON extraction', () {
      test('parses raw JSON that starts with {', () {
        const raw =
            '{"intent":"prayerTime","responseType":"text","text":"Hello"}';
        final result = IntentParser.parse(raw);
        expect(result, isNotNull);
        expect(result!.intent, ChatIntent.prayerTime);
        expect(result.text, 'Hello');
      });

      test('trims leading/trailing whitespace around raw JSON', () {
        const raw = '  \n  {"intent":"tasbih","responseType":"text"}  \n';
        final result = IntentParser.parse(raw);
        expect(result, isNotNull);
        expect(result!.intent, ChatIntent.tasbih);
      });

      test('extracts JSON from ```json fenced code block', () {
        const raw = '''
Some chatter before.
```json
{"intent":"qibla","responseType":"text","text":"Qibla here"}
```
Some chatter after.
''';
        final result = IntentParser.parse(raw);
        expect(result, isNotNull);
        expect(result!.intent, ChatIntent.qibla);
        expect(result.text, 'Qibla here');
      });

      test('extracts JSON from bare ``` fenced code block', () {
        const raw = '''
```
{"intent":"duaRequest","responseType":"text"}
```
''';
        final result = IntentParser.parse(raw);
        expect(result, isNotNull);
        expect(result!.intent, ChatIntent.duaRequest);
      });

      test('falls back to greedy {...} match when no fences are present', () {
        const raw =
            'Sure! {"intent":"learning","responseType":"text","text":"ok"} — cheers.';
        final result = IntentParser.parse(raw);
        expect(result, isNotNull);
        expect(result!.intent, ChatIntent.learning);
      });

      test('returns null for plain text with no JSON-like content', () {
        final result = IntentParser.parse('No JSON at all here.');
        expect(result, isNull);
      });

      test('returns null for malformed JSON', () {
        const raw = '{"intent": prayerTime,}';
        final result = IntentParser.parse(raw);
        expect(result, isNull);
      });

      test('returns null for an empty string', () {
        expect(IntentParser.parse(''), isNull);
      });
    });

    group('intent parsing', () {
      test('maps each known intent string to its enum value', () {
        for (final intent in ChatIntent.values) {
          final raw = '{"intent":"${intent.name}","responseType":"text"}';
          expect(IntentParser.parse(raw)!.intent, intent,
              reason: 'intent=${intent.name}');
        }
      });

      test('defaults to generalQuestion when intent is missing', () {
        const raw = '{"responseType":"text","text":"hi"}';
        expect(IntentParser.parse(raw)!.intent, ChatIntent.generalQuestion);
      });

      test('defaults to generalQuestion when intent is unknown', () {
        const raw = '{"intent":"bogus","responseType":"text"}';
        expect(IntentParser.parse(raw)!.intent, ChatIntent.generalQuestion);
      });
    });

    group('responseType parsing', () {
      test('accepts camelCase responseType key', () {
        const raw = '{"intent":"qibla","responseType":"component",'
            '"component":{"type":"qibla","data":{}}}';
        expect(IntentParser.parse(raw)!.responseType, ResponseType.component);
      });

      test('accepts snake_case response_type key', () {
        const raw = '{"intent":"qibla","response_type":"component",'
            '"component":{"type":"qibla","data":{}}}';
        expect(IntentParser.parse(raw)!.responseType, ResponseType.component);
      });

      test('defaults to text when responseType is missing', () {
        const raw = '{"intent":"generalQuestion"}';
        expect(IntentParser.parse(raw)!.responseType, ResponseType.text);
      });

      test('defaults to text for unknown responseType values', () {
        const raw = '{"intent":"generalQuestion","responseType":"weird"}';
        expect(IntentParser.parse(raw)!.responseType, ResponseType.text);
      });
    });

    group('component parsing', () {
      test('parses a well-formed component with a data map', () {
        const raw = '{"intent":"prayerTime","responseType":"component",'
            '"component":{"type":"prayerTimes",'
            '"data":{"prayers":[],"date":"2026-04-23"}}}';
        final result = IntentParser.parse(raw)!;
        expect(result.component, isNotNull);
        expect(result.component!.type, 'prayerTimes');
        expect(result.component!.data['date'], '2026-04-23');
      });

      test('flattens fields into data when LLM omits the "data" key', () {
        const raw = '{"intent":"tasbih","responseType":"component",'
            '"component":{"type":"tasbih",'
            '"dhikrText":"SubhanAllah","targetCount":33}}';
        final result = IntentParser.parse(raw)!;
        expect(result.component, isNotNull);
        expect(result.component!.type, 'tasbih');
        expect(result.component!.data['dhikrText'], 'SubhanAllah');
        expect(result.component!.data['targetCount'], 33);
        expect(result.component!.data.containsKey('type'), isFalse);
      });

      test('returns null component when component.type is missing', () {
        const raw = '{"intent":"qibla","responseType":"component",'
            '"component":{"data":{}}}';
        expect(IntentParser.parse(raw)!.component, isNull);
      });

      test('returns null component when component.type is empty', () {
        const raw = '{"intent":"qibla","responseType":"component",'
            '"component":{"type":"","data":{}}}';
        expect(IntentParser.parse(raw)!.component, isNull);
      });

      test('returns null component when component field is not a map', () {
        const raw =
            '{"intent":"qibla","responseType":"component","component":"nope"}';
        expect(IntentParser.parse(raw)!.component, isNull);
      });

      test('returns null component when field is absent', () {
        const raw = '{"intent":"generalQuestion","responseType":"text"}';
        expect(IntentParser.parse(raw)!.component, isNull);
      });
    });

    group('text parsing', () {
      test('preserves text field when present', () {
        const raw =
            '{"intent":"generalQuestion","responseType":"text","text":"Salam"}';
        expect(IntentParser.parse(raw)!.text, 'Salam');
      });

      test('leaves text null when absent', () {
        const raw = '{"intent":"generalQuestion","responseType":"text"}';
        expect(IntentParser.parse(raw)!.text, isNull);
      });

      test('allows explicit null text', () {
        const raw =
            '{"intent":"generalQuestion","responseType":"text","text":null}';
        expect(IntentParser.parse(raw)!.text, isNull);
      });
    });
  });

  group('IntentParser.fallbackTextResponse', () {
    test('wraps raw text as a generalQuestion text response', () {
      final result = IntentParser.fallbackTextResponse('just a string');
      expect(result.intent, ChatIntent.generalQuestion);
      expect(result.responseType, ResponseType.text);
      expect(result.text, 'just a string');
      expect(result.component, isNull);
    });
  });
}

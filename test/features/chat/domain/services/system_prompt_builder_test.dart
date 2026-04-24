import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/features/chat/domain/services/system_prompt_builder.dart';

void main() {
  group('SystemPromptBuilder.build', () {
    group('madhab', () {
      test('embeds the madhab display name in the header', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.hanafi,
          language: 'en',
        );
        expect(prompt, contains("User's madhab: Hanafi"));
      });

      test('embeds each madhab in the fiqh rule', () {
        for (final m in Madhab.values) {
          final prompt = SystemPromptBuilder.build(
            madhab: m,
            language: 'en',
          );
          expect(prompt, contains('Follow ${m.displayName} fiqh'),
              reason: 'madhab=${m.name}');
        }
      });
    });

    group('language', () {
      test('maps "ar" to Arabic with native name', () {
        final prompt =
            SystemPromptBuilder.build(madhab: Madhab.shafii, language: 'ar');
        expect(prompt, contains('Arabic (العربية)'));
        expect(prompt, contains("User's language: Arabic (العربية)"));
      });

      test('maps "ru" to Russian with native name', () {
        final prompt =
            SystemPromptBuilder.build(madhab: Madhab.hanafi, language: 'ru');
        expect(prompt, contains('Russian (Русский)'));
      });

      test('maps anything else (including "en") to English', () {
        final en =
            SystemPromptBuilder.build(madhab: Madhab.hanafi, language: 'en');
        final other =
            SystemPromptBuilder.build(madhab: Madhab.hanafi, language: 'xx');
        expect(en, contains("User's language: English"));
        expect(other, contains("User's language: English"));
      });

      test('repeats the language multiple times (critical + rules)', () {
        final prompt =
            SystemPromptBuilder.build(madhab: Madhab.hanafi, language: 'ru');
        // Appears in header, CRITICAL RULE, and in Rules section.
        final occurrences = 'Russian (Русский)'.allMatches(prompt).length +
            'Russian'.allMatches(prompt).length;
        expect(occurrences, greaterThanOrEqualTo(3));
        expect(prompt, contains('CRITICAL RULE'));
      });
    });

    group('location', () {
      test('includes lat/lng when latitude is provided', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          latitude: 41.31,
          longitude: 69.24,
        );
        expect(prompt, contains("User's location: lat 41.31, lng 69.24"));
        expect(prompt, isNot(contains("User's location: unknown")));
      });

      test('falls back to "unknown" when latitude is null', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
        );
        expect(prompt, contains("User's location: unknown"));
      });

      test('treats missing latitude as unknown even if longitude is given', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          longitude: 69.24,
        );
        expect(prompt, contains("User's location: unknown"));
      });
    });

    group('userName', () {
      test('includes the user name line when present', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          userName: 'Amina',
        );
        expect(prompt, contains("User's name: Amina"));
      });

      test('omits the user name line when absent', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
        );
        expect(prompt, isNot(contains("User's name:")));
      });
    });

    group('learning context', () {
      test('omits learning progress when null', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
        );
        expect(prompt, isNot(contains('Learning progress')));
      });

      test('formats progress as integer percentage', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          learningProgress: 0.375,
        );
        expect(prompt, contains('Learning progress: 37%'));
      });

      test('rounds down (truncates) the percentage', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          learningProgress: 0.999,
        );
        expect(prompt, contains('Learning progress: 99%'));
      });

      test('reports 0% for zero progress', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          learningProgress: 0,
        );
        expect(prompt, contains('Learning progress: 0%'));
      });

      test('includes current lesson id when supplied alongside progress', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          learningProgress: 0.5,
          currentLessonId: 'wudu',
        );
        expect(prompt, contains('Learning progress: 50%'));
        expect(prompt, contains('current lesson: wudu'));
      });

      test('omits current lesson suffix when id is null', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          learningProgress: 0.5,
        );
        expect(prompt, contains('Learning progress: 50%'));
        expect(prompt, isNot(contains('current lesson')));
      });

      test('omits current lesson entirely when progress is null', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
          currentLessonId: 'wudu',
        );
        // Without progress, the whole learning block should be absent.
        expect(prompt, isNot(contains('Learning progress')));
        expect(prompt, isNot(contains('current lesson')));
      });
    });

    group('structural invariants', () {
      test('advertises the full intent and response_type schema', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
        );
        // Every ChatIntent value must appear in the documented schema
        // so the LLM learns the exact set it can emit.
        for (final intent in ChatIntent.values) {
          expect(prompt, contains(intent.name),
              reason: 'intent ${intent.name} missing from prompt');
        }
        // Required component types documented in the schema.
        const componentTypes = [
          'prayerTimes',
          'quranAyah',
          'dua',
          'tasbih',
          'qibla',
          'learningStart',
          'learningProgress',
          'lessonCard',
        ];
        for (final type in componentTypes) {
          expect(prompt, contains(type),
              reason: 'component type $type missing from prompt');
        }
      });

      test('includes the information-not-a-fatwa disclaimer', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.hanafi,
          language: 'en',
        );
        expect(prompt, contains('This is information, not a fatwa.'));
      });

      test('includes an ISO-8601 timestamp for current time', () {
        final prompt = SystemPromptBuilder.build(
          madhab: Madhab.shafii,
          language: 'en',
        );
        final match = RegExp(r'Current time: (\S+)').firstMatch(prompt);
        expect(match, isNotNull);
        // Parsing round-trips for valid ISO-8601.
        expect(() => DateTime.parse(match!.group(1)!), returnsNormally);
      });
    });
  });
}

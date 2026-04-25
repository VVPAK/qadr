import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';
import 'package:qadr/features/chat/domain/services/component_context_builder.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';

void main() {
  group('ComponentContextBuilder.buildContextJson', () {
    test('pass-through types include the original type and data', () {
      for (final type in const [
        'prayerTimes',
        'quranAyah',
        'dua',
        'tasbih',
        'qibla',
      ]) {
        final result = ComponentContextBuilder.buildContextJson(
          ComponentPayload(type: type, data: const {'k': 'v'}),
        );
        expect(result['type'], type, reason: type);
        expect(result['k'], 'v', reason: type);
      }
    });

    test('lessonCard is enriched with title/description/stepsCount for a '
        'known lessonId', () {
      final lesson = learningCurriculum.first.lessons.first;
      final result = ComponentContextBuilder.buildContextJson(
        ComponentPayload(type: 'lessonCard', data: {'lessonId': lesson.id}),
      );
      expect(result['type'], 'lessonCard');
      expect(result['lessonId'], lesson.id);
      expect(result['title'], lesson.title);
      expect(result['titleAr'], lesson.titleAr);
      expect(result['description'], lesson.description);
      expect(result['stepsCount'], lesson.steps.length);
    });

    test('lessonCard with an unknown lessonId falls back to the raw data', () {
      final result = ComponentContextBuilder.buildContextJson(
        ComponentPayload(
          type: 'lessonCard',
          data: {'lessonId': 'does_not_exist'},
        ),
      );
      expect(result['type'], 'lessonCard');
      expect(result['lessonId'], 'does_not_exist');
      expect(result.containsKey('title'), isFalse);
      expect(result.containsKey('stepsCount'), isFalse);
    });

    test('lessonCard without a lessonId falls back to the raw data', () {
      final result = ComponentContextBuilder.buildContextJson(
        ComponentPayload(
          type: 'lessonCard',
          data: const {'somethingElse': true},
        ),
      );
      expect(result['type'], 'lessonCard');
      expect(result['somethingElse'], isTrue);
    });

    test('learningStart is enriched with the first curriculum lesson', () {
      final firstLesson = learningCurriculum.first.lessons.first;
      final result = ComponentContextBuilder.buildContextJson(
        const ComponentPayload(type: 'learningStart', data: {}),
      );
      expect(result['type'], 'learningStart');
      expect(result['lessonId'], firstLesson.id);
      expect(result['title'], firstLesson.title);
      expect(result['titleAr'], firstLesson.titleAr);
    });

    test('pass-through types never clobber the explicit "type" field', () {
      final result = ComponentContextBuilder.buildContextJson(
        const ComponentPayload(
          type: 'prayerTimes',
          data: {'prayers': [], 'date': '2026-04-23'},
        ),
      );
      expect(result['type'], 'prayerTimes');
      expect(result['date'], '2026-04-23');
      expect(result['prayers'], isEmpty);
    });
  });
}

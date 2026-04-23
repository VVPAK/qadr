import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';

void main() {
  group('LearningStep.localized* methods', () {
    const step = LearningStep(
      title: 'Wudu',
      titleAr: 'الوضوء',
      titleRu: 'Вуду',
      content: 'Ablution before prayer.',
      contentRu: 'Омовение перед молитвой.',
      tip: 'Start with the right hand.',
      tipRu: 'Начни с правой руки.',
    );

    test('localizedTitle picks by language code', () {
      expect(step.localizedTitle('ar'), 'الوضوء');
      expect(step.localizedTitle('ru'), 'Вуду');
      expect(step.localizedTitle('en'), 'Wudu');
      expect(step.localizedTitle('xx'), 'Wudu',
          reason: 'unknown locales fall through to English');
    });

    test('localizedContent picks Russian or defaults to English', () {
      expect(step.localizedContent('ru'), 'Омовение перед молитвой.');
      expect(step.localizedContent('en'), 'Ablution before prayer.');
      expect(step.localizedContent('ar'), 'Ablution before prayer.',
          reason: 'no Arabic content field — falls through to English');
    });

    test('localizedTip returns Russian when set, falls through to English',
        () {
      expect(step.localizedTip('ru'), 'Начни с правой руки.');
      expect(step.localizedTip('en'), 'Start with the right hand.');
      expect(step.localizedTip('ar'), 'Start with the right hand.');
    });

    test('localizedTip falls back to English tip when Russian tip is null',
        () {
      const s = LearningStep(
        title: 't',
        titleAr: 't',
        titleRu: 't',
        content: 'c',
        contentRu: 'c',
        tip: 'Only English tip',
      );
      expect(s.localizedTip('ru'), 'Only English tip');
    });

    test('localizedTip returns null when both tips are null', () {
      const s = LearningStep(
        title: 't',
        titleAr: 't',
        titleRu: 't',
        content: 'c',
        contentRu: 'c',
      );
      expect(s.localizedTip('en'), isNull);
      expect(s.localizedTip('ru'), isNull);
    });
  });

  group('Lesson.localized* methods', () {
    const lesson = Lesson(
      id: 'l1',
      title: 'T',
      titleAr: 'ت',
      titleRu: 'Т',
      description: 'D',
      descriptionRu: 'Д',
      steps: [],
    );

    test('picks per-language title', () {
      expect(lesson.localizedTitle('ar'), 'ت');
      expect(lesson.localizedTitle('ru'), 'Т');
      expect(lesson.localizedTitle('en'), 'T');
    });

    test('picks Russian description or defaults to English', () {
      expect(lesson.localizedDescription('ru'), 'Д');
      expect(lesson.localizedDescription('en'), 'D');
      expect(lesson.localizedDescription('ar'), 'D');
    });
  });

  group('LearningModule.localized* methods', () {
    const module = LearningModule(
      id: 'm1',
      title: 'M',
      titleAr: 'م',
      titleRu: 'М',
      description: 'D',
      descriptionRu: 'Д',
      lessons: [],
    );

    test('picks per-language title', () {
      expect(module.localizedTitle('ar'), 'م');
      expect(module.localizedTitle('ru'), 'М');
      expect(module.localizedTitle('en'), 'M');
    });

    test('description localizes only ru/en', () {
      expect(module.localizedDescription('ru'), 'Д');
      expect(module.localizedDescription('en'), 'D');
      expect(module.localizedDescription('ar'), 'D');
    });
  });

  group('learningCurriculum data invariants', () {
    test('every lesson id is unique across the whole curriculum', () {
      final ids = <String>{};
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          expect(ids.add(lesson.id), isTrue,
              reason: 'duplicate lesson id: ${lesson.id}');
        }
      }
    });

    test('every lesson has at least one step', () {
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          expect(lesson.steps, isNotEmpty,
              reason: 'empty lesson: ${lesson.id}');
        }
      }
    });

    test('every lesson fills out all three locales (title + description)',
        () {
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          expect(lesson.title, isNotEmpty, reason: lesson.id);
          expect(lesson.titleAr, isNotEmpty, reason: lesson.id);
          expect(lesson.titleRu, isNotEmpty, reason: lesson.id);
          expect(lesson.description, isNotEmpty, reason: lesson.id);
          expect(lesson.descriptionRu, isNotEmpty, reason: lesson.id);
        }
      }
    });
  });
}

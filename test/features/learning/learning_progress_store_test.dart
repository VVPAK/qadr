import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LearningProgressStore> _buildStore([
  Map<String, Object> initial = const {},
]) async {
  SharedPreferences.setMockInitialValues(initial);
  return LearningProgressStore(await SharedPreferences.getInstance());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LearningProgressStore defaults', () {
    test('progress is empty, hasStarted is false, ids are null', () async {
      final store = await _buildStore();
      expect(store.progress, isEmpty);
      expect(store.hasStarted, isFalse);
      expect(store.currentModuleId, isNull);
      expect(store.currentLessonId, isNull);
    });

    test('getCompletedStep returns -1 for an unseen lesson', () async {
      final store = await _buildStore();
      expect(store.getCompletedStep('shahada'), -1);
    });

    test('overallProgress is 0 on a fresh store', () async {
      final store = await _buildStore();
      expect(store.overallProgress, 0);
    });
  });

  group('LearningProgressStore.completeStep', () {
    test('records a step and exposes it via getCompletedStep', () async {
      final store = await _buildStore();
      store.completeStep('shahada', 0);
      expect(store.getCompletedStep('shahada'), 0);
    });

    test('advances when a higher step index is completed', () async {
      final store = await _buildStore();
      store.completeStep('shahada', 0);
      store.completeStep('shahada', 2);
      expect(store.getCompletedStep('shahada'), 2);
    });

    test('does not regress when a lower step is replayed', () async {
      final store = await _buildStore();
      store.completeStep('shahada', 2);
      store.completeStep('shahada', 0);
      expect(store.getCompletedStep('shahada'), 2);
    });

    test('persists across new store instances backed by same prefs', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      LearningProgressStore(prefs).completeStep('shahada', 1);
      final restored = LearningProgressStore(prefs);
      expect(restored.getCompletedStep('shahada'), 1);
    });
  });

  group('LearningProgressStore.isLessonComplete / isModuleComplete', () {
    test('an unknown lesson id is never complete', () async {
      final store = await _buildStore();
      expect(store.isLessonComplete('not_a_real_lesson'), isFalse);
    });

    test(
      'a lesson becomes complete when its last step is marked done',
      () async {
        final lesson = learningCurriculum.first.lessons.first;
        final store = await _buildStore();
        expect(store.isLessonComplete(lesson.id), isFalse);
        store.completeStep(lesson.id, lesson.steps.length - 1);
        expect(store.isLessonComplete(lesson.id), isTrue);
      },
    );

    test(
      'a module is complete only when every lesson in it is complete',
      () async {
        final module = learningCurriculum.first;
        final store = await _buildStore();
        // Complete every lesson except the last.
        for (final lesson in module.lessons.take(module.lessons.length - 1)) {
          store.completeStep(lesson.id, lesson.steps.length - 1);
        }
        expect(store.isModuleComplete(module.id), isFalse);

        final last = module.lessons.last;
        store.completeStep(last.id, last.steps.length - 1);
        expect(store.isModuleComplete(module.id), isTrue);
      },
    );

    test('an unknown module id is never complete', () async {
      final store = await _buildStore();
      expect(store.isModuleComplete('phantom_module'), isFalse);
    });
  });

  group('LearningProgressStore.overallProgress', () {
    test('reaches 1.0 when every lesson is fully completed', () async {
      final store = await _buildStore();
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          store.completeStep(lesson.id, lesson.steps.length - 1);
        }
      }
      expect(store.overallProgress, 1.0);
    });

    test('is between 0 and 1 when partially completed', () async {
      final store = await _buildStore();
      final lesson = learningCurriculum.first.lessons.first;
      store.completeStep(lesson.id, 0); // one step
      final p = store.overallProgress;
      expect(p, greaterThan(0));
      expect(p, lessThan(1));
    });

    test('clamps contribution of a lesson to its number of steps', () async {
      // Completing beyond step count should not inflate progress.
      final store = await _buildStore();
      final lesson = learningCurriculum.first.lessons.first;
      store.completeStep(lesson.id, 9999);
      final completedOnlyThisLesson = store.overallProgress;

      // Compare against manually completing exactly the last step.
      final store2 = await _buildStore();
      store2.completeStep(lesson.id, lesson.steps.length - 1);
      expect(completedOnlyThisLesson, store2.overallProgress);
    });
  });

  group('LearningProgressStore.getNextLesson', () {
    test('returns the first lesson on a fresh store', () async {
      final store = await _buildStore();
      final next = store.getNextLesson();
      expect(next, isNotNull);
      expect(next!.module.id, learningCurriculum.first.id);
      expect(next.lesson.id, learningCurriculum.first.lessons.first.id);
    });

    test('returns null once every lesson is complete', () async {
      final store = await _buildStore();
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          store.completeStep(lesson.id, lesson.steps.length - 1);
        }
      }
      expect(store.getNextLesson(), isNull);
    });

    test('skips already-completed lessons', () async {
      final store = await _buildStore();
      final first = learningCurriculum.first.lessons.first;
      store.completeStep(first.id, first.steps.length - 1);
      final next = store.getNextLesson();
      expect(next, isNotNull);
      expect(next!.lesson.id, isNot(first.id));
    });
  });

  group('LearningProgressStore getters/setters', () {
    test('hasStarted, currentModuleId, currentLessonId persist', () async {
      final store = await _buildStore();
      store.hasStarted = true;
      store.currentModuleId = 'foundations';
      store.currentLessonId = 'shahada';
      expect(store.hasStarted, isTrue);
      expect(store.currentModuleId, 'foundations');
      expect(store.currentLessonId, 'shahada');
    });

    test('null clears currentModuleId and currentLessonId', () async {
      final store = await _buildStore();
      store.currentModuleId = 'foundations';
      store.currentLessonId = 'shahada';
      store.currentModuleId = null;
      store.currentLessonId = null;
      expect(store.currentModuleId, isNull);
      expect(store.currentLessonId, isNull);
    });
  });
}

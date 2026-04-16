import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/learning_curriculum.dart';

class LearningProgressStore {
  LearningProgressStore(this._prefs);
  final SharedPreferences _prefs;

  static const _keyProgress = 'learning_progress';
  static const _keyCurrentModule = 'learning_current_module';
  static const _keyCurrentLesson = 'learning_current_lesson';
  static const _keyStarted = 'learning_started';

  /// Map of lessonId -> completedStepIndex (0-based, -1 = not started)
  Map<String, int> get progress {
    final raw = _prefs.getString(_keyProgress);
    if (raw == null) return {};
    return (jsonDecode(raw) as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, v as int));
  }

  void _saveProgress(Map<String, int> p) {
    _prefs.setString(_keyProgress, jsonEncode(p));
  }

  bool get hasStarted => _prefs.getBool(_keyStarted) ?? false;
  set hasStarted(bool v) => _prefs.setBool(_keyStarted, v);

  String? get currentModuleId => _prefs.getString(_keyCurrentModule);
  set currentModuleId(String? v) {
    if (v != null) {
      _prefs.setString(_keyCurrentModule, v);
    } else {
      _prefs.remove(_keyCurrentModule);
    }
  }

  String? get currentLessonId => _prefs.getString(_keyCurrentLesson);
  set currentLessonId(String? v) {
    if (v != null) {
      _prefs.setString(_keyCurrentLesson, v);
    } else {
      _prefs.remove(_keyCurrentLesson);
    }
  }

  /// Mark a step as completed in a lesson.
  void completeStep(String lessonId, int stepIndex) {
    final p = progress;
    final current = p[lessonId] ?? -1;
    if (stepIndex > current) {
      p[lessonId] = stepIndex;
      _saveProgress(p);
    }
  }

  /// Get the highest completed step index for a lesson (-1 if not started).
  int getCompletedStep(String lessonId) => progress[lessonId] ?? -1;

  /// Check if a lesson is fully completed.
  bool isLessonComplete(String lessonId) {
    final lesson = _findLesson(lessonId);
    if (lesson == null) return false;
    return getCompletedStep(lessonId) >= lesson.steps.length - 1;
  }

  /// Check if a module is fully completed.
  bool isModuleComplete(String moduleId) {
    final module = learningCurriculum.where((m) => m.id == moduleId).firstOrNull;
    if (module == null) return false;
    return module.lessons.every((l) => isLessonComplete(l.id));
  }

  /// Overall progress: fraction of all lessons completed (0.0 to 1.0).
  double get overallProgress {
    int totalSteps = 0;
    int completedSteps = 0;
    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        totalSteps += lesson.steps.length;
        final done = getCompletedStep(lesson.id) + 1;
        completedSteps += done.clamp(0, lesson.steps.length);
      }
    }
    return totalSteps == 0 ? 0 : completedSteps / totalSteps;
  }

  /// Get the next lesson to study.
  ({LearningModule module, Lesson lesson})? getNextLesson() {
    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        if (!isLessonComplete(lesson.id)) {
          return (module: module, lesson: lesson);
        }
      }
    }
    return null;
  }

  Lesson? _findLesson(String lessonId) {
    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        if (lesson.id == lessonId) return lesson;
      }
    }
    return null;
  }
}

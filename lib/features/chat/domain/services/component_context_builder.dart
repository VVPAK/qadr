import '../../../learning/domain/learning_curriculum.dart';
import '../models/llm_response.dart';

/// Builds LLM-context JSON from a [ComponentPayload].
///
/// Mirrors the [ChatComponent.toContextJson] contract on the widget side,
/// but works from raw payload data so it can be used in the LLM service
/// without instantiating widgets.
///
/// For most component types this is a pass-through of [ComponentPayload.data].
/// For types whose raw data is incomplete (e.g. `lessonCard` stores only a
/// `lessonId`), the builder enriches it with resolved details.
class ComponentContextBuilder {
  const ComponentContextBuilder._();

  static Map<String, dynamic> buildContextJson(ComponentPayload component) {
    return switch (component.type) {
      'lessonCard' => _enrichLessonData(component.data),
      'learningStart' => _enrichLearningStartData(),
      _ => {'type': component.type, ...component.data},
    };
  }

  static Map<String, dynamic> _enrichLessonData(Map<String, dynamic> data) {
    final lessonId = data['lessonId'] as String?;
    if (lessonId == null) return {'type': 'lessonCard', ...data};

    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        if (lesson.id == lessonId) {
          return {
            'type': 'lessonCard',
            'lessonId': lesson.id,
            'title': lesson.title,
            'titleAr': lesson.titleAr,
            'description': lesson.description,
            'stepsCount': lesson.steps.length,
          };
        }
      }
    }

    return {'type': 'lessonCard', ...data};
  }

  static Map<String, dynamic> _enrichLearningStartData() {
    final firstLesson = learningCurriculum.first.lessons.first;
    return {
      'type': 'learningStart',
      'lessonId': firstLesson.id,
      'title': firstLesson.title,
      'titleAr': firstLesson.titleAr,
    };
  }
}

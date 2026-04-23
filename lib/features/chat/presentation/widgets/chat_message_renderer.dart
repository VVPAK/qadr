import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../domain/models/component_data.dart';
import '../../domain/models/llm_response.dart';
import '../../../../features/prayer/presentation/widgets/prayer_times_card.dart';
import '../../../../features/quran/presentation/widgets/quran_ayah_card.dart';
import '../../../../features/tasbih/presentation/widgets/tasbih_counter_widget.dart';
import '../../../../features/qibla/presentation/widgets/qibla_compass_widget.dart';
import '../../../../features/learning/presentation/widgets/lesson_card_widget.dart';
import '../../../../features/learning/presentation/widgets/learning_progress_card.dart';
import '../../../../features/learning/domain/learning_curriculum.dart';
import 'dua_chat_card.dart';

import '../../../../app/theme.dart';

class ChatMessageRenderer extends StatelessWidget {
  const ChatMessageRenderer({super.key, required this.response});
  final LlmResponse response;

  @override
  Widget build(BuildContext context) {
    if (response.responseType == ResponseType.text || response.component == null) {
      return MarkdownBody(
        data: response.text ?? '',
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
      );
    }

    final component = response.component!;
    final textWidget = response.text != null && response.text!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: QadrSpacing.sm),
            child: MarkdownBody(
              data: response.text!,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            ),
          )
        : null;

    final componentWidget = switch (component.type) {
      'prayerTimes' => PrayerTimesCard(
          data: PrayerTimesData.fromJson(component.data),
        ),
      'quranAyah' => QuranAyahCard(
          data: QuranAyahData.fromJson(component.data),
        ),
      'dua' => DuaChatCard(
          data: DuaData.fromJson(component.data),
        ),
      'tasbih' => TasbihCounterWidget(
          data: TasbihData.fromJson(component.data),
        ),
      'qibla' => const QiblaCompassWidget(),
      'learningStart' => _buildLearningStart(context),
      'learningProgress' => const LearningProgressCard(),
      'lessonCard' => _buildLessonCard(component.data),
      _ => MarkdownBody(
          data: response.text ?? 'Unknown component: ${component.type}',
        ),
    };

    if (textWidget != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [textWidget, componentWidget],
      );
    }

    return componentWidget;
  }

  Widget _buildLearningStart(BuildContext context) {
    // Show the first lesson (Shahada) to get started
    final firstModule = learningCurriculum.first;
    final firstLesson = firstModule.lessons.first;
    return LessonCardWidget(lesson: firstLesson);
  }

  Widget _buildLessonCard(Map<String, dynamic> data) {
    final lessonId = data['lessonId'] as String?
        ?? data['lesson_id'] as String?;
    if (lessonId == null) {
      return const Text('Invalid lesson');
    }

    // Find the lesson in curriculum
    for (final module in learningCurriculum) {
      for (final lesson in module.lessons) {
        if (lesson.id == lessonId) {
          return LessonCardWidget(lesson: lesson);
        }
      }
    }

    return Text('Lesson not found: $lessonId');
  }
}

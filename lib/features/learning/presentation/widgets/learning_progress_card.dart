import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/chat_component.dart';
import '../../domain/learning_curriculum.dart';
import '../providers/learning_provider.dart';

import '../../../../app/theme.dart';

class LearningProgressCard extends ConsumerWidget with ChatComponent {
  const LearningProgressCard({super.key, this.onContinue});
  final void Function(Lesson lesson)? onContinue;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'learningProgress',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(learningStateProvider);
    final store = ref.watch(learningProgressProvider);
    final progress = store.overallProgress;
    final next = store.getNextLesson();

    final lang = Localizations.localeOf(context).languageCode;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(QadrSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: context.colorScheme.primary),
                const SizedBox(width: QadrSpacing.sm),
                Text(
                  context.l10n.yourLearningJourney,
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Progress bar
            ClipRRect(
              borderRadius: QadrRadius.smAll,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: QadrSpacing.xs),
            Text(
              context.l10n.percentComplete((progress * 100).toInt()),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 12),
            // Module overview
            ...learningCurriculum.map((module) {
              final isComplete = store.isModuleComplete(module.id);
              final lessonsDone = module.lessons
                  .where((l) => store.isLessonComplete(l.id))
                  .length;

              return Padding(
                padding: const EdgeInsets.only(bottom: QadrSpacing.sm),
                child: Row(
                  children: [
                    Icon(
                      isComplete
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 18,
                      color: isComplete
                          ? context.colorScheme.primary
                          : context.colorScheme.outline,
                    ),
                    const SizedBox(width: QadrSpacing.sm),
                    Expanded(
                      child: Text(
                        '${module.icon} ${module.localizedTitle(lang)}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          decoration:
                              isComplete ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    Text(
                      '$lessonsDone/${module.lessons.length}',
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              );
            }),
            if (next != null) ...[
              const SizedBox(height: QadrSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => onContinue?.call(next.lesson),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: Text(
                    context.l10n.continueLesson(
                      next.lesson.localizedTitle(lang),
                    ),
                  ),
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  context.l10n.allLessonsComplete,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/chat_component.dart';
import '../../domain/learning_curriculum.dart';
import '../providers/learning_provider.dart';

class LessonCardWidget extends ConsumerStatefulWidget with ChatComponent {
  const LessonCardWidget({
    super.key,
    required this.lesson,
    this.startAtStep = 0,
  });

  final Lesson lesson;
  final int startAtStep;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'lessonCard',
        'lessonId': lesson.id,
        'title': lesson.title,
        'titleAr': lesson.titleAr,
        'description': lesson.description,
        'stepsCount': lesson.steps.length,
      };

  @override
  ConsumerState<LessonCardWidget> createState() => _LessonCardWidgetState();
}

class _LessonCardWidgetState extends ConsumerState<LessonCardWidget>
    with AutomaticKeepAliveClientMixin {
  late int _currentStep;
  late PageController _pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.startAtStep;
    _pageController = PageController(initialPage: _currentStep);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onStepViewed(int stepIndex) {
    ref.read(learningStateProvider.notifier).completeStep(
          widget.lesson.id,
          stepIndex,
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Watch state to rebuild on progress change
    ref.watch(learningStateProvider);
    final steps = widget.lesson.steps;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: context.colorScheme.primaryContainer,
            child: Row(
              children: [
                Text(widget.lesson.icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.lesson.localizedTitle(
                          Localizations.localeOf(context).languageCode,
                        ),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_currentStep + 1} / ${steps.length}',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Progress bar
          LinearProgressIndicator(
            value: (_currentStep + 1) / steps.length,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            color: context.colorScheme.primary,
            minHeight: 3,
          ),
          // Step content
          SizedBox(
            height: 350,
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              onPageChanged: (index) {
                setState(() => _currentStep = index);
                _onStepViewed(index);
              },
              itemBuilder: (context, index) {
                return _StepContent(step: steps[index]);
              },
            ),
          ),
          // Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                if (_currentStep > 0)
                  TextButton.icon(
                    onPressed: () => _goToStep(_currentStep - 1),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: Text(context.l10n.back),
                  )
                else
                  const SizedBox(width: 80),
                const Spacer(),
                if (_currentStep < steps.length - 1)
                  FilledButton.icon(
                    onPressed: () => _goToStep(_currentStep + 1),
                    icon: Text(context.l10n.next),
                    label: const Icon(Icons.arrow_forward, size: 16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepContent extends StatelessWidget {
  const _StepContent({required this.step});
  final LearningStep step;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            step.localizedTitle(lang),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (lang != 'ar' && step.titleAr.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              step.titleAr,
              style: GoogleFonts.amiri(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ],
          const SizedBox(height: 12),
          Text(
            step.localizedContent(lang),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
          if (step.arabicText != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    step.arabicText!,
                    style: GoogleFonts.amiri(
                      fontSize: 22,
                      height: 1.8,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  if (step.transliteration != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      step.transliteration!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
          if (step.localizedTip(lang) != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      step.localizedTip(lang)!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onTertiaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

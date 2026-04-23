import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../app/theme.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/widgets/scene_background.dart';
import '../../../../core/widgets/scene_page.dart';
import 'onboarding_atoms.dart';

class OnboardingWelcomeStep extends ConsumerWidget {
  final VoidCallback onNext;

  const OnboardingWelcomeStep({super.key, required this.onNext});

  static const _languages = [
    ('ru', 'RU'),
    ('en', 'EN'),
    ('ar', 'AR'),
  ];

  Future<void> _setLanguage(WidgetRef ref, String code) async {
    ref.read(localProvider.notifier).state = Locale(code);
    final prefs = await ref.read(userPreferencesProvider.future);
    prefs.language = code;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = ref.watch(localProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: SceneType.dawn,
      topGradientStrength: 0.45,
      children: [
        // Wordmark
        Positioned(
          top: topPadding + 22,
          left: 0,
          right: 0,
          child: const Center(child: OnbMark()),
        ),

        // Language toggle — compact glass pill under wordmark
        Positioned(
          top: topPadding + 70,
          left: 0,
          right: 0,
          child: Center(
            child: OnbGlassPill(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _languages.map((e) {
                  final active = locale.languageCode == e.$1;
                  return GestureDetector(
                    onTap: () => _setLanguage(ref, e.$1),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: active
                            ? QadrColors.cream.withValues(alpha: 0.95)
                            : Colors.transparent,
                      ),
                      child: Text(
                        e.$2,
                        style: TextStyle(
                          color: active
                              ? QadrColors.text
                              : QadrColors.cream.withValues(alpha: 0.82),
                          fontFamily: 'GeneralSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // Basmala — single thin arabic line
        Positioned(
          top: topPadding + 134,
          left: 0,
          right: 0,
          child: Text(
            l10n.onboardingWelcomeBasmala,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: QadrTheme.arabic(
              fontSize: 22,
              height: 1.2,
              color: QadrColors.cream.withValues(alpha: 0.78),
            ),
          ),
        ),

        // Hero headline + description
        Positioned(
          top: topPadding + 290,
          left: 32,
          right: 32,
          child: Column(
            children: [
              OnbHeadline(
                line1: l10n.onboardingWelcomeHeadline1,
                line2: l10n.onboardingWelcomeHeadline2,
                fontSize: 44,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: 280,
                child: Text(
                  l10n.onboardingWelcomeSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: QadrColors.cream.withValues(alpha: 0.78),
                    fontFamily: 'GeneralSans',
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),

        const OnbDots(current: 0),
        OnbCTA(
          label: l10n.onboardingWelcomeCta,
          onTap: onNext,
        ),
      ],
    );
  }
}

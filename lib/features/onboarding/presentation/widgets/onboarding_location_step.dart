import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/providers/widget_service_provider.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scene_background.dart';
import '../../../../core/widgets/scene_page.dart';
import 'onboarding_atoms.dart';

class OnboardingLocationStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const OnboardingLocationStep({super.key, required this.onNext});

  @override
  ConsumerState<OnboardingLocationStep> createState() =>
      _OnboardingLocationStepState();
}

class _OnboardingLocationStepState
    extends ConsumerState<OnboardingLocationStep> {
  bool _requesting = false;

  Future<void> _requestPermission() async {
    if (_requesting) return;
    setState(() => _requesting = true);
    try {
      final prefs = await ref.read(userPreferencesProvider.future);
      await ref
          .read(locationServiceProvider)
          .requestAndFetchPosition(prefs);
      unawaited(ref.read(widgetServiceProvider)?.update());
    } finally {
      if (mounted) setState(() => _requesting = false);
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: SceneType.dune,
      topGradientStrength: 0.38,
      children: [
        Positioned(
          top: topPadding + 72,
          left: 0,
          right: 0,
          child: OnbEyebrow(text: l10n.onboardingLocationStepLabel),
        ),

        Positioned(
          top: topPadding + 110,
          left: 32,
          right: 32,
          child: OnbHeadline(
            line1: l10n.onboardingLocationHeadline1,
            line2: l10n.onboardingLocationHeadline2,
          ),
        ),

        Positioned(
          top: topPadding + 296,
          left: 28,
          right: 28,
          child: GlassContainer(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            borderRadius: 22,
            backgroundOpacity: 0.45,
            borderOpacity: 0.12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: QadrColors.cream.withValues(alpha: 0.08),
                        border: Border.all(
                          color: QadrColors.cream.withValues(alpha: 0.18),
                        ),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: QadrColors.cream,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: QadrSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.onboardingLocationCardTitle,
                            style: const TextStyle(
                              color: QadrColors.cream,
                              fontFamily: 'GeneralSans',
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.15,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            l10n.onboardingLocationCardDesc,
                            style: TextStyle(
                              color:
                                  QadrColors.cream.withValues(alpha: 0.62),
                              fontFamily: 'GeneralSans',
                              fontSize: 12.5,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: QadrSpacing.md),
                  child: Container(
                    height: 1,
                    color: QadrColors.cream.withValues(alpha: 0.1),
                  ),
                ),
                Text(
                  l10n.onboardingLocationPrivacy,
                  style: TextStyle(
                    color: QadrColors.cream.withValues(alpha: 0.55),
                    fontFamily: 'GeneralSans',
                    fontSize: 11.5,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ),

        const OnbDots(current: 2),
        OnbCTAStack(
          primaryLabel: l10n.onboardingLocationAllow,
          onPrimary: _requestPermission,
          secondaryLabel: l10n.onboardingLocationManual,
          onSecondary: widget.onNext,
        ),
      ],
    );
  }
}

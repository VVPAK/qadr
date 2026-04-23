import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scene_background.dart';
import '../../../../core/widgets/scene_page.dart';
import '../../../../l10n/app_localizations.dart';
import 'onboarding_atoms.dart';

class OnboardingNotificationsStep extends ConsumerWidget {
  final VoidCallback onNext;

  const OnboardingNotificationsStep({super.key, required this.onNext});

  static const _rows = [
    _Row('fajr', '04:52'),
    _Row('dhuhr', '12:47'),
    _Row('asr', '16:18', active: true),
    _Row('maghrib', '18:54'),
    _Row('isha', '20:31'),
  ];

  Future<void> _setAndNext(WidgetRef ref, bool enabled) async {
    final prefs = await ref.read(userPreferencesProvider.future);
    prefs.notificationsEnabled = enabled;
    onNext();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: SceneType.night,
      topGradientStrength: 0.5,
      children: [
        Positioned(
          top: topPadding + 72,
          left: 0,
          right: 0,
          child: OnbEyebrow(text: l10n.onboardingNotifsStepLabel),
        ),

        Positioned(
          top: topPadding + 110,
          left: 32,
          right: 32,
          child: Column(
            children: [
              OnbHeadline(
                line1: l10n.onboardingNotifsHeadline1,
                line2: l10n.onboardingNotifsHeadline2,
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: 300,
                child: Text(
                  l10n.onboardingNotifsSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: QadrColors.cream.withValues(alpha: 0.7),
                    fontFamily: 'GeneralSans',
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Glass preview card with prayer list
        Positioned(
          top: topPadding + 324,
          left: 28,
          right: 28,
          child: GlassContainer(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
            borderRadius: 22,
            backgroundOpacity: 0.45,
            borderOpacity: 0.12,
            child: Column(
              children: [
                for (var i = 0; i < _rows.length; i++)
                  _PrayerRowView(
                    row: _rows[i],
                    label: _labelFor(l10n, _rows[i].id),
                    showDivider: i != _rows.length - 1,
                  ),
              ],
            ),
          ),
        ),

        const OnbDots(current: 3),
        OnbCTAStack(
          primaryLabel: l10n.onboardingNotifsAllow,
          onPrimary: () => _setAndNext(ref, true),
          secondaryLabel: l10n.onboardingNotifsDecline,
          onSecondary: () => _setAndNext(ref, false),
        ),
      ],
    );
  }

  String _labelFor(AppLocalizations l10n, String id) {
    switch (id) {
      case 'fajr':
        return l10n.fajr;
      case 'dhuhr':
        return l10n.dhuhr;
      case 'asr':
        return l10n.asr;
      case 'maghrib':
        return l10n.maghrib;
      case 'isha':
        return l10n.isha;
    }
    return id;
  }
}

class _Row {
  final String id;
  final String time;
  final bool active;
  const _Row(this.id, this.time, {this.active = false});
}

class _PrayerRowView extends StatelessWidget {
  final _Row row;
  final String label;
  final bool showDivider;

  const _PrayerRowView({
    required this.row,
    required this.label,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final active = row.active;
    final opacity = active ? 1.0 : 0.75;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: QadrColors.cream.withValues(alpha: 0.07),
                  width: 1,
                ),
              )
            : null,
      ),
      child: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: QadrRadius.xsAll,
                border: Border.all(
                  color: QadrColors.cream.withValues(alpha: 0.35),
                ),
                color: active
                    ? QadrColors.cream.withValues(alpha: 0.92)
                    : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: active
                  ? const Icon(Icons.check,
                      size: 10, color: QadrColors.text)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: QadrColors.cream,
                  fontFamily: 'GeneralSans',
                  fontSize: 15,
                  fontWeight: active ? FontWeight.w500 : FontWeight.w400,
                  letterSpacing: -0.15,
                ),
              ),
            ),
            Text(
              row.time,
              style: QadrTheme.numeral(
                fontSize: 15,
                color: active
                    ? QadrColors.cream
                    : QadrColors.cream.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

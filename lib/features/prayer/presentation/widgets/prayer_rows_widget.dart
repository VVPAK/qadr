import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/models/component_data.dart';

/// Renders a list of prayer rows (name | spacer | time) with glass-style
/// colours. Passive prayers (sunrise) are shown at reduced opacity.
/// Intended to be embedded inside a [GlassContainer] by the caller.
class PrayerRowsWidget extends StatelessWidget {
  const PrayerRowsWidget({super.key, required this.prayers});

  final List<PrayerTimeEntry> prayers;

  static bool _isPassive(String name) => name == 'sunrise';

  static String _localizeName(String name, AppLocalizations l10n) {
    return switch (name) {
      'fajr' => l10n.fajr,
      'sunrise' => l10n.sunrise,
      'dhuhr' => l10n.dhuhr,
      'asr' => l10n.asr,
      'maghrib' => l10n.maghrib,
      'isha' => l10n.isha,
      _ => name,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < prayers.length; i++)
          _buildRow(context, prayers[i], i < prayers.length - 1),
      ],
    );
  }

  Widget _buildRow(BuildContext context, PrayerTimeEntry prayer, bool showBorder) {
    const cream = Color(0xFFF4EFE6);
    const muted = Color(0x6BF4EFE6);
    final passive = _isPassive(prayer.name);
    final textColor = (passive || !prayer.isNext) ? (passive ? muted : cream) : const Color(0xFFF8EEDC);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 2),
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x12FFFFFF))),
            )
          : null,
      child: Opacity(
        opacity: passive ? 0.6 : 1.0,
        child: Row(
          children: [
            Text(
              _localizeName(prayer.name, context.l10n),
              style: TextStyle(
                fontSize: 16,
                fontWeight: prayer.isNext ? FontWeight.w500 : FontWeight.w400,
                color: textColor,
                letterSpacing: -0.1,
              ),
            ),
            if (passive)
              Padding(
                padding: const EdgeInsets.only(left: QadrSpacing.sm),
                child: Text(
                  context.l10n.sunrise.toLowerCase(),
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ),
            const Spacer(),
            const SizedBox(width: QadrSpacing.md),
            Container(
              padding: prayer.isNext
                  ? const EdgeInsets.symmetric(horizontal: 9, vertical: 3)
                  : EdgeInsets.zero,
              decoration: prayer.isNext
                  ? BoxDecoration(
                      color: const Color(0x1AFFFFFF),
                      borderRadius: BorderRadius.circular(7),
                    )
                  : null,
              child: Text(
                prayer.time,
                style: QadrTheme.numeral(
                  fontSize: 16,
                  fontWeight: prayer.isNext ? FontWeight.w500 : FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../chat/domain/chat_component.dart';
import '../../../chat/domain/models/component_data.dart';

class PrayerTimesCard extends StatelessWidget with ChatComponent {
  const PrayerTimesCard({super.key, required this.data});
  final PrayerTimesData data;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'prayerTimes',
        ...data.toJson(),
      };

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.mosque, color: context.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  context.l10n.prayerTimes,
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  data.date,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...data.prayers.map((prayer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      if (prayer.isNext)
                        Container(
                          width: 4,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      else
                        const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _localizeName(prayer.name, context.l10n),
                          style: prayer.isNext
                              ? context.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)
                              : context.textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        prayer.time,
                        style: prayer.isNext
                            ? context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              )
                            : context.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

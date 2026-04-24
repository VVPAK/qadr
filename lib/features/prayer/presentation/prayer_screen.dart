import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/extensions/datetime_extensions.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../core/utils/hijri_date.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';
import '../../../core/models/prayer_time_model.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/services/clock.dart';
import 'providers/prayer_times_provider.dart';
import 'widgets/prayer_rows_widget.dart';
import '../../../features/chat/domain/models/component_data.dart';

class PrayerScreen extends ConsumerStatefulWidget {
  final ValueChanged<NavSection> onNavChanged;

  const PrayerScreen({super.key, required this.onNavChanged});

  @override
  ConsumerState<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends ConsumerState<PrayerScreen> {
  int _sceneIdx = 0;
  Timer? _timer;
  late DateTime _now;

  static const _scenes = [
    SceneType.dusk,
    SceneType.dune,
    SceneType.night,
    SceneType.dawn,
  ];

  @override
  void initState() {
    super.initState();
    _now = ref.read(clockProvider).now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = ref.read(clockProvider).now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prefsAsync = ref.watch(userPreferencesProvider);

    return prefsAsync.when(
      loading: () => const ColoredBox(
        color: Color(0xFF2A2420),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) =>
          Center(child: Text(context.l10n.errorWithMessage(e.toString()))),
      data: (prefs) {
        final lat = prefs.latitude ?? 55.79;
        final lng = prefs.longitude ?? 49.12;
        final model = ref.read(prayerTimesServiceProvider).calculate(
              latitude: lat,
              longitude: lng,
              date: _now,
            );
        return _buildContent(model, cityName: prefs.cityName ?? 'Казань');
      },
    );
  }

  Widget _buildContent(
    PrayerTimeModel model, {
    required String cityName,
  }) {
    final rawPrayers = [
      (key: 'fajr', time: model.fajr, isPassive: false),
      (key: 'sunrise', time: model.sunrise, isPassive: true),
      (key: 'dhuhr', time: model.dhuhr, isPassive: false),
      (key: 'asr', time: model.asr, isPassive: false),
      (key: 'maghrib', time: model.maghrib, isPassive: false),
      (key: 'isha', time: model.isha, isPassive: false),
    ];

    // Find next active prayer
    final activePrayers = rawPrayers.where((p) => !p.isPassive).toList();
    ({String key, DateTime time, bool isPassive})? next;
    for (final p in activePrayers) {
      if (p.time.isAfter(_now)) {
        next = p;
        break;
      }
    }
    next ??= activePrayers.first; // wrap to fajr tomorrow

    final diff = next.time.difference(_now);
    final h = diff.inHours.clamp(0, 99);
    final m = (diff.inMinutes % 60).clamp(0, 59);
    final s = (diff.inSeconds % 60).clamp(0, 59);
    final countdown =
        '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    final prayers = rawPrayers.map((p) {
      final isPassed = !p.isPassive && p.time.isBefore(_now) && p.key != next!.key;
      return PrayerTimeEntry(
        name: p.key,
        time: p.time.timeString,
        isNext: p.key == next!.key,
        isPassed: isPassed,
        isPassive: p.isPassive,
      );
    }).toList();

    final nextName = switch (next.key) {
      'fajr' => context.l10n.fajr,
      'dhuhr' => context.l10n.dhuhr,
      'asr' => context.l10n.asr,
      'maghrib' => context.l10n.maghrib,
      'isha' => context.l10n.isha,
      _ => next.key,
    };

    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: _scenes[_sceneIdx],
      children: [
        Positioned(
          top: topPadding + 10,
          left: 22,
          right: 22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScenePicker(),
              const Spacer(),
              _buildCityInfo(cityName: cityName),
            ],
          ),
        ),

        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 280),
                child: IntrinsicWidth(
                  child: _buildPrayerCard(prayers, nextName, countdown),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScenePicker() {
    return GestureDetector(
      onTap: () => setState(
        () => _sceneIdx = (_sceneIdx + 1) % _scenes.length,
      ),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        borderRadius: 999,
        blur: 10,
        backgroundOpacity: 0.35,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_scenes.length, (i) {
            final isActive = i == _sceneIdx;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 18 : 6,
              height: 6,
              margin: EdgeInsets.only(right: i < _scenes.length - 1 ? 6 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isActive
                    ? const Color(0xFFF4EFE6)
                    : const Color(0x73F4EFE6),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCityInfo({required String cityName}) {
    final hijri = HijriDate.fromGregorian(_now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on_outlined,
                size: 13, color: Color(0xFFF4EFE6)),
            const SizedBox(width: QadrSpacing.xs),
            Text(
              cityName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFF4EFE6),
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          hijri.formattedRu(),
          style: QadrTheme.display(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xA6F4EFE6),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerCard(
      List<PrayerTimeEntry> prayers, String nextName, String countdown) {
    return GlassContainer(
      borderRadius: 24,
      blur: 22,
      backgroundOpacity: 0.55,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: QadrSpacing.screenH, vertical: 14),
            child: PrayerRowsWidget(prayers: prayers),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: QadrSpacing.screenH, vertical: 13),
            decoration: const BoxDecoration(
              color: Color(0x8C8A6E4F),
              border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
            ),
            child: Row(
              children: [
                Text(
                  nextName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF8EEDC),
                    letterSpacing: -0.1,
                  ),
                ),
                const Spacer(),
                Text(
                  '−$countdown',
                  style: QadrTheme.numeral(
                    fontSize: 16,
                    color: const Color(0xFFF8EEDC),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

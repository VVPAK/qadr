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
import '../../../core/services/clock.dart';
import 'providers/prayer_times_provider.dart';

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
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (prefs) {
        final lat = prefs.latitude ?? 55.79; // Kazan default
        final lng = prefs.longitude ?? 49.12;
        final service = ref.read(prayerTimesServiceProvider);
        final prayerModel = service.calculate(
          latitude: lat,
          longitude: lng,
          date: _now,
        );
        return _buildContent(
          prayerModel,
          cityName: prefs.cityName ?? 'Казань',
        );
      },
    );
  }

  Widget _buildContent(
    PrayerTimeModel model, {
    required String cityName,
  }) {
    final prayers = [
      _PrayerRow('Фаджр', model.fajr, false),
      _PrayerRow('Восход', model.sunrise, true),
      _PrayerRow('Зухр', model.dhuhr, false),
      _PrayerRow('Аср', model.asr, false),
      _PrayerRow('Магриб', model.maghrib, false),
      _PrayerRow('Иша', model.isha, false),
    ];

    // Find next prayer
    final activePrayers = prayers.where((p) => !p.passive).toList();
    _PrayerRow? next;
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

    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: _scenes[_sceneIdx],
      children: [
        // Top row: scene picker + city info
        Positioned(
          top: topPadding + 10,
          left: 22,
          right: 22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scene picker dots
              _buildScenePicker(),
              const Spacer(),
              // City + Hijri date
              _buildCityInfo(cityName: cityName),
            ],
          ),
        ),

        // Floating glass prayer card — centred vertically and horizontally
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 280),
                child: IntrinsicWidth(
                  child: _buildPrayerCard(prayers, next, countdown),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScenePicker() {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      borderRadius: 999,
      blur: 10,
      backgroundOpacity: 0.35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_scenes.length, (i) {
          final isActive = i == _sceneIdx;
          return GestureDetector(
            onTap: () => setState(() => _sceneIdx = i),
            child: AnimatedContainer(
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
            ),
          );
        }),
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
      List<_PrayerRow> prayers, _PrayerRow next, String countdown) {
    return GlassContainer(
      borderRadius: 24,
      blur: 22,
      backgroundOpacity: 0.55,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(QadrSpacing.screenH, 14, QadrSpacing.screenH, QadrSpacing.sm),
            child: Column(
              children: [
                for (int i = 0; i < prayers.length; i++)
                  _buildPrayerRow(prayers[i], next, i < prayers.length - 1),
              ],
            ),
          ),
          // Countdown footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: QadrSpacing.screenH, vertical: 13),
            decoration: const BoxDecoration(
              color: Color(0x8C8A6E4F),
              border: Border(
                top: BorderSide(color: Color(0x14FFFFFF)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  next.name,
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

  Widget _buildPrayerRow(_PrayerRow prayer, _PrayerRow next, bool showBorder) {
    final isNext = prayer.name == next.name;
    final passed = !prayer.passive &&
        prayer.time.isBefore(_now) &&
        !isNext;
    final muted = const Color(0x6BF4EFE6);

    Color textColor;
    if (prayer.passive || passed) {
      textColor = muted;
    } else {
      textColor = const Color(0xFFF4EFE6);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 2),
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x12FFFFFF)),
              ),
            )
          : null,
      child: Opacity(
        opacity: prayer.passive ? 0.6 : (passed ? 0.5 : 1.0),
        child: Row(
          children: [
            Text(
              prayer.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isNext ? FontWeight.w500 : FontWeight.w400,
                color: textColor,
                letterSpacing: -0.1,
              ),
            ),
            if (prayer.passive)
              Padding(
                padding: const EdgeInsets.only(left: QadrSpacing.sm),
                child: Text(
                  'восход',
                  style: TextStyle(fontSize: 11, color: muted),
                ),
              ),
            const Spacer(),
            const SizedBox(width: QadrSpacing.md),
            Container(
              padding: isNext
                  ? const EdgeInsets.symmetric(horizontal: 9, vertical: 3)
                  : EdgeInsets.zero,
              decoration: isNext
                  ? BoxDecoration(
                      color: const Color(0x1AFFFFFF),
                      borderRadius: BorderRadius.circular(7),
                    )
                  : null,
              child: Text(
                prayer.time.timeString,
                style: QadrTheme.numeral(
                  fontSize: 16,
                  fontWeight: isNext ? FontWeight.w500 : FontWeight.w400,
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

class _PrayerRow {
  final String name;
  final DateTime time;
  final bool passive;

  _PrayerRow(this.name, this.time, this.passive);
}

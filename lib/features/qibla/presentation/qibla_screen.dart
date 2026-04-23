import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../core/services/location_service.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';
import '../domain/qibla_providers.dart';
import '../domain/qibla_service.dart';

class QiblaScreen extends ConsumerWidget {
  final ValueChanged<NavSection> onNavChanged;

  const QiblaScreen({super.key, required this.onNavChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final readingAsync = ref.watch(qiblaReadingProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: SceneType.night,
      topGradientStrength: 0.5,
      children: [
        prefsAsync.when(
          loading: () => const _Centered(
            child: CircularProgressIndicator(color: Color(0xFFF4EFE6)),
          ),
          error: (e, _) => _Centered(child: Text('Error: $e')),
          data: (prefs) {
            final lat = prefs.latitude;
            final lng = prefs.longitude;
            if (lat == null || lng == null) {
              return _LocationRequestCard(
                onGranted: () {
                  ref.invalidate(userPreferencesProvider);
                },
              );
            }
            return readingAsync.when(
              loading: () => const _Centered(
                child:
                    CircularProgressIndicator(color: Color(0xFFF4EFE6)),
              ),
              error: (e, _) => _Centered(child: Text('Error: $e')),
              data: (reading) {
                if (reading == null) {
                  return _LocationRequestCard(
                    onGranted: () {
                      ref.invalidate(userPreferencesProvider);
                    },
                  );
                }
                return _QiblaBody(
                  reading: reading,
                  cityName: prefs.cityName,
                  lat: lat,
                  lng: lng,
                  topPadding: topPadding,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _QiblaBody extends StatelessWidget {
  const _QiblaBody({
    required this.reading,
    required this.cityName,
    required this.lat,
    required this.lng,
    required this.topPadding,
  });

  final QiblaReading reading;
  final String? cityName;
  final double lat;
  final double lng;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final locationLabel = cityName ??
        '${lat.toStringAsFixed(2)}°, ${lng.toStringAsFixed(2)}°';

    return Stack(
      children: [
        Positioned(
          top: topPadding + 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const Text(
                'КИБЛА',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Color(0x99F4EFE6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$locationLabel · ${reading.bearing.round()}° от севера',
                style: QadrTheme.display(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xD1F4EFE6),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Center(child: _QiblaCompass(reading: reading)),
        ),
      ],
    );
  }
}

class _QiblaCompass extends ConsumerStatefulWidget {
  const _QiblaCompass({required this.reading});
  final QiblaReading reading;

  @override
  ConsumerState<_QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends ConsumerState<_QiblaCompass> {
  bool _timedOut = false;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _timeoutTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _timedOut = true);
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compassAsync = ref.watch(compassEventsProvider);

    return compassAsync.when(
      loading: () => _buildCompass(
        heading: 0,
        accuracy: null,
        hasCompass: !_timedOut,
      ),
      error: (_, _) => _buildCompass(
        heading: 0,
        accuracy: null,
        hasCompass: false,
      ),
      data: (event) {
        if (event == null) {
          return _buildCompass(
            heading: 0,
            accuracy: null,
            hasCompass: !_timedOut,
          );
        }
        if (event.heading != null && _timeoutTimer?.isActive == true) {
          _timeoutTimer?.cancel();
        }
        return _buildCompass(
          heading: event.heading ?? 0,
          accuracy: event.accuracy,
          hasCompass: event.heading != null,
        );
      },
    );
  }

  Widget _buildCompass({
    required double heading,
    required double? accuracy,
    required bool hasCompass,
  }) {
    final reading = widget.reading;
    final effectiveHeading = hasCompass ? heading : 0.0;
    // When there's no compass, lock the needle to the raw qibla bearing so
    // the dial is informative rather than stuck at 0.
    final diff = hasCompass
        ? ((reading.magneticBearing - effectiveHeading + 540) % 360) - 180
        : null;
    final needleAngle = diff ?? reading.bearing;
    final aligned = diff != null && diff.abs() < 3;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 310,
          height: 310,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 310,
                height: 310,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0x1FF4EFE6)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 60,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
              ),
              Transform.rotate(
                angle: -effectiveHeading * math.pi / 180,
                child: CustomPaint(
                  size: const Size(310, 310),
                  painter: _CompassTicksPainter(heading: effectiveHeading),
                ),
              ),
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: aligned
                        ? const Color(0xE6F4EFE6)
                        : const Color(0x2EF4EFE6),
                  ),
                ),
              ),
              Transform.rotate(
                angle: needleAngle * math.pi / 180,
                child: CustomPaint(
                  size: const Size(240, 240),
                  painter: _NeedlePainter(
                    color: aligned
                        ? const Color(0xFFF4EFE6)
                        : const Color(0xFFE4C7A0),
                    aligned: aligned,
                  ),
                ),
              ),
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: aligned
                      ? const Color(0xFFF4EFE6)
                      : const Color(0xFFE4C7A0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 46),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 26,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4EFE6),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 22,
                          height: 4,
                          margin: const EdgeInsets.only(top: 2),
                          color: const Color(0xCC8C6A4A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'КААБА',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 2,
                        color: Color(0xB3F4EFE6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        _ReadoutPill(
          reading: reading,
          diff: diff,
          aligned: aligned,
          accuracy: accuracy,
          hasCompass: hasCompass,
        ),
      ],
    );
  }
}

class _ReadoutPill extends StatelessWidget {
  const _ReadoutPill({
    required this.reading,
    required this.diff,
    required this.aligned,
    required this.accuracy,
    required this.hasCompass,
  });

  final QiblaReading reading;
  final double? diff;
  final bool aligned;
  final double? accuracy;
  final bool hasCompass;

  @override
  Widget build(BuildContext context) {
    final String primary;
    final String secondary;
    final bool italic;

    if (!hasCompass) {
      primary = '${reading.bearing.round()}° от севера';
      secondary = 'Компас недоступен на этом устройстве';
      italic = false;
    } else if (aligned) {
      primary = 'Точно на Каабу';
      secondary = _calibrationLabel(accuracy);
      italic = true;
    } else {
      final d = diff!.abs().round();
      primary = '$d° ${diff! > 0 ? 'вправо' : 'влево'}';
      secondary = _calibrationLabel(accuracy);
      italic = false;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0x80140C0C),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          child: Column(
            children: [
              Text(
                primary,
                style: QadrTheme.display(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                  color: const Color(0xFFF4EFE6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                secondary,
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 1,
                  color: Color(0x8CF4EFE6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // flutter_compass reports accuracy in radians. <15° = high, <30° = medium,
  // else low. Null means unknown — prompt the user to calibrate.
  String _calibrationLabel(double? accuracy) {
    if (accuracy == null) {
      return 'Покачайте телефон восьмёркой для калибровки';
    }
    if (accuracy < 0.26) return 'Точность калибровки: высокая';
    if (accuracy < 0.52) return 'Точность калибровки: средняя';
    return 'Точность калибровки: низкая — калибруйте';
  }
}

class _LocationRequestCard extends ConsumerStatefulWidget {
  const _LocationRequestCard({required this.onGranted});
  final VoidCallback onGranted;

  @override
  ConsumerState<_LocationRequestCard> createState() =>
      _LocationRequestCardState();
}

class _LocationRequestCardState extends ConsumerState<_LocationRequestCard> {
  bool _loading = false;

  Future<void> _request() async {
    setState(() => _loading = true);
    final prefs = await ref.read(userPreferencesProvider.future);
    final ok = await ref
        .read(locationServiceProvider)
        .requestAndFetchPosition(prefs);
    if (!mounted) return;
    setState(() => _loading = false);
    if (ok) widget.onGranted();
  }

  @override
  Widget build(BuildContext context) {
    return _Centered(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 320),
            decoration: BoxDecoration(
              color: const Color(0x80140C0C),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFFE4C7A0),
                  size: 42,
                ),
                const SizedBox(height: 14),
                Text(
                  'Разрешите доступ к геолокации',
                  textAlign: TextAlign.center,
                  style: QadrTheme.display(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF4EFE6),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Нужно определить ваше местоположение, чтобы направить стрелку на Каабу.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xB3F4EFE6),
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: _loading ? null : _request,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE4C7A0),
                    foregroundColor: const Color(0xFF140C0C),
                    minimumSize: const Size.fromHeight(44),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF140C0C),
                          ),
                        )
                      : const Text('Определить местоположение'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: Center(child: child));
  }
}

class _CompassTicksPainter extends CustomPainter {
  final double heading;
  _CompassTicksPainter({required this.heading});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    for (int i = 0; i < 72; i++) {
      final isMajor = i % 9 == 0;
      final isSub = i % 3 == 0;
      final len = isMajor ? 16.0 : isSub ? 9.0 : 4.0;
      final op = isMajor ? 0.95 : isSub ? 0.55 : 0.25;

      final angle = i * 5 * math.pi / 180;
      final outerR = cx - 14;
      final innerR = outerR - len;
      final startX = cx + outerR * math.sin(angle);
      final startY = cy - outerR * math.cos(angle);
      final endX = cx + innerR * math.sin(angle);
      final endY = cy - innerR * math.cos(angle);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        Paint()
          ..color = const Color(0xFFF4EFE6).withValues(alpha: op)
          ..strokeWidth = isMajor ? 1.5 : 0.8
          ..strokeCap = StrokeCap.round,
      );
    }

    const cardinals = [
      ('С', 0.0, true),
      ('В', 90.0, false),
      ('Ю', 180.0, false),
      ('З', 270.0, false),
    ];
    for (final (letter, angleDeg, isNorth) in cardinals) {
      final angle = angleDeg * math.pi / 180;
      const r = 118.0;
      final x = cx + r * math.sin(angle);
      final y = cy - r * math.cos(angle);

      final tp = TextPainter(
        text: TextSpan(
          text: letter,
          style: QadrTheme.display(
            fontSize: 14,
            fontStyle: isNorth ? FontStyle.italic : FontStyle.normal,
            color: isNorth
                ? const Color(0xFFF4EFE6)
                : const Color(0x8CF4EFE6),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(heading * math.pi / 180);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CompassTicksPainter old) => old.heading != heading;
}

class _NeedlePainter extends CustomPainter {
  final Color color;
  final bool aligned;
  _NeedlePainter({required this.color, required this.aligned});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx, 28),
      Paint()
        ..color = color
        ..strokeWidth = aligned ? 2.4 : 1.8
        ..strokeCap = StrokeCap.round,
    );

    canvas.save();
    canvas.translate(cx, 28);
    final starPaint = Paint()
      ..color = const Color(0xD9140E0E)
      ..style = PaintingStyle.fill;
    final starStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final rect = Rect.fromCenter(
        center: Offset.zero, width: 16, height: 16);
    canvas.drawRect(rect, starPaint);
    canvas.drawRect(rect, starStroke);
    canvas.save();
    canvas.rotate(math.pi / 4);
    canvas.drawRect(rect, starPaint);
    canvas.drawRect(rect, starStroke);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(_NeedlePainter old) =>
      old.color != color || old.aligned != aligned;
}

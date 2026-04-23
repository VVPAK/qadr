import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';

class QiblaScreen extends ConsumerWidget {
  final ValueChanged<NavSection> onNavChanged;

  const QiblaScreen({super.key, required this.onNavChanged});

  double _calculateQibla(double lat, double lng) {
    const kaabaLat = AppConstants.kaabaLatitude * math.pi / 180;
    const kaabaLng = AppConstants.kaabaLongitude * math.pi / 180;
    final userLat = lat * math.pi / 180;
    final userLng = lng * math.pi / 180;
    final dLng = kaabaLng - userLng;
    final y = math.sin(dLng);
    final x = math.cos(userLat) * math.tan(kaabaLat) -
        math.sin(userLat) * math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPreferencesProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return prefsAsync.when(
      loading: () => const ColoredBox(
        color: Color(0xFF1A1F2A),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (prefs) {
        final lat = prefs.latitude ?? 55.79;
        final lng = prefs.longitude ?? 49.12;
        final qiblaDeg = _calculateQibla(lat, lng);

        return ScenePage(
          scene: SceneType.night,
          activeNav: NavSection.qibla,
          onNavChanged: onNavChanged,
          topGradientStrength: 0.5,
          children: [
            // Title
            Positioned(
              top: topPadding + 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'КИБЛА',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: const Color(0x99F4EFE6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Казань · ${qiblaDeg.round()}° от севера',
                    style: QadrTheme.display(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xD1F4EFE6),
                    ),
                  ),
                ],
              ),
            ),

            // Compass
            Positioned.fill(
              child: Center(
                child: _QiblaCompass(qiblaDeg: qiblaDeg),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QiblaCompass extends StatelessWidget {
  final double qiblaDeg;
  const _QiblaCompass({required this.qiblaDeg});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final heading = snapshot.data?.heading ?? 0.0;
        final diff = ((qiblaDeg - heading + 540) % 360) - 180;
        final aligned = diff.abs() < 3;
        final needleAngle = qiblaDeg - heading;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Compass dial
            SizedBox(
              width: 310,
              height: 310,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glass halo
                  Container(
                    width: 310,
                    height: 310,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0x1FF4EFE6),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x66000000),
                          blurRadius: 60,
                          offset: Offset(0, 20),
                        ),
                      ],
                    ),
                  ),

                  // Tick marks + cardinal letters (rotates with heading)
                  Transform.rotate(
                    angle: -heading * math.pi / 180,
                    child: CustomPaint(
                      size: const Size(310, 310),
                      painter: _CompassTicksPainter(heading: heading),
                    ),
                  ),

                  // Inner ring
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

                  // Qibla needle
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

                  // Center dot
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

                  // Kaaba glyph
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

            // Readout pill
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0x80140C0C),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: const Color(0x1AFFFFFF)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        aligned
                            ? 'Точно на Каабу'
                            : '${diff.abs().round()}° ${diff > 0 ? 'вправо' : 'влево'}',
                        style: QadrTheme.display(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          fontStyle:
                              aligned ? FontStyle.italic : FontStyle.normal,
                          color: const Color(0xFFF4EFE6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Точность калибровки: высокая',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1,
                          color: const Color(0x8CF4EFE6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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

    // Cardinal letters
    const cardinals = [
      ('С', 0.0, true),
      ('В', 90.0, false),
      ('Ю', 180.0, false),
      ('З', 270.0, false),
    ];
    for (final (letter, angleDeg, isNorth) in cardinals) {
      final angle = angleDeg * math.pi / 180;
      final r = 118.0;
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

    // Line from center to top
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx, 28),
      Paint()
        ..color = color
        ..strokeWidth = aligned ? 2.4 : 1.8
        ..strokeCap = StrokeCap.round,
    );

    // 8-point star at tip
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

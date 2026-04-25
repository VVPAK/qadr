import 'package:flutter/material.dart';

/// Scene identifiers used across the app.
enum SceneType { dusk, dune, night, dawn }

/// Full-bleed gradient background scene. Each scene is a
/// custom-painted gradient landscape (dusk, dune, night, dawn).
class SceneBackground extends StatelessWidget {
  final SceneType scene;

  const SceneBackground({super.key, required this.scene});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ScenePainter(scene), size: Size.infinite);
  }
}

class _ScenePainter extends CustomPainter {
  final SceneType scene;
  _ScenePainter(this.scene);

  @override
  void paint(Canvas canvas, Size size) {
    switch (scene) {
      case SceneType.dusk:
        _paintDusk(canvas, size);
      case SceneType.dune:
        _paintDune(canvas, size);
      case SceneType.night:
        _paintNight(canvas, size);
      case SceneType.dawn:
        _paintDawn(canvas, size);
    }
  }

  void _paintDusk(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky gradient
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFF5A5B6B),
          Color(0xFF7E6F70),
          Color(0xFFB88668),
          Color(0xFFC69266),
          Color(0xFF5C3E2B),
        ],
        stops: const [0, 0.4, 0.65, 0.85, 1],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // Sun glow
    final glowPaint = Paint()
      ..color =
          const Color(0x73FFDCB4) // rgba(255,220,180,0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(Offset(w * 0.68, h * 0.57), 48, glowPaint);

    final sunPaint = Paint()..color = const Color(0xCCFFECD2);
    canvas.drawCircle(Offset(w * 0.68, h * 0.57), 22, sunPaint);

    // Hills
    final hill1 = Path()
      ..moveTo(0, h * 0.76)
      ..lineTo(w * 0.15, h * 0.71)
      ..lineTo(w * 0.33, h * 0.74)
      ..lineTo(w * 0.54, h * 0.68)
      ..lineTo(w * 0.77, h * 0.73)
      ..lineTo(w, h * 0.70)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hill1, Paint()..color = const Color(0x993F3530));

    final hill2 = Path()
      ..moveTo(0, h * 0.83)
      ..lineTo(w * 0.21, h * 0.79)
      ..lineTo(w * 0.46, h * 0.83)
      ..lineTo(w * 0.69, h * 0.78)
      ..lineTo(w, h * 0.82)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hill2, Paint()..color = const Color(0xCC2A221F));
  }

  void _paintDune(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFD8B88A), Color(0xFFC69870), Color(0xFF8C5A3A)],
        stops: const [0, 0.5, 1],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    final dune1 = Path()
      ..moveTo(0, h * 0.76)
      ..quadraticBezierTo(w * 0.26, h * 0.63, w * 0.56, h * 0.71)
      ..quadraticBezierTo(w * 0.80, h * 0.77, w, h * 0.68)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final dune1Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFA67048), Color(0xFF6B3E22)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(
      dune1,
      dune1Paint..color = dune1Paint.color.withAlpha(0xD9),
    );

    final dune2 = Path()
      ..moveTo(0, h * 0.88)
      ..quadraticBezierTo(w * 0.38, h * 0.80, w * 0.77, h * 0.87)
      ..quadraticBezierTo(w * 0.90, h * 0.89, w, h * 0.85)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(dune2, Paint()..color = const Color(0xBF4E2E1A));
  }

  void _paintNight(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF1A1F2A), Color(0xFF2A2E3A), Color(0xFF3A3530)],
        stops: const [0, 0.55, 1],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // Crescent moon
    final moonPaint = Paint()..color = const Color(0xE6F5EBD2);
    canvas.drawCircle(Offset(w * 0.23, h * 0.22), 36, moonPaint);
    final moonMask = Paint()..color = const Color(0xFF1A1F2A);
    canvas.drawCircle(Offset(w * 0.26, h * 0.215), 36, moonMask);

    // Stars
    final starPaint = Paint()..color = const Color(0xB3FFF0D7);
    for (int i = 0; i < 40; i++) {
      final x = (i * 37) % (w.toInt() - 10) + 5.0;
      final y = (i * 53) % (h * 0.61).toInt() + 20.0;
      final r = (i % 3) * 0.4 + 0.6;
      canvas.drawCircle(Offset(x, y), r, starPaint);
    }

    // Ground
    final ground = Path()
      ..moveTo(0, h * 0.83)
      ..lineTo(w, h * 0.78)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(ground, Paint()..color = const Color(0xE61A1512));
  }

  void _paintDawn(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          Color(0xFF2E3A4A),
          Color(0xFF6B6F78),
          Color(0xFFC8A88A),
          Color(0xFFE7C3A0),
          Color(0xFF8C6A50),
        ],
        stops: const [0, 0.35, 0.6, 0.82, 1],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // Sun glow
    final glowPaint = Paint()
      ..color = const Color(0x99FFE6C3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(Offset(w * 0.5, h * 0.73), 80, glowPaint);

    final sunPaint = Paint()..color = const Color(0xF2FFF4DE);
    canvas.drawCircle(Offset(w * 0.5, h * 0.73), 34, sunPaint);

    // Ground
    final ground = Path()
      ..moveTo(0, h * 0.78)
      ..lineTo(w, h * 0.78)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(ground, Paint()..color = const Color(0x995A3E2E));
  }

  @override
  bool shouldRepaint(_ScenePainter old) => old.scene != scene;
}

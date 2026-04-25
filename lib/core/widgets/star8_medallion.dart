import 'dart:math';
import 'package:flutter/material.dart';

/// An 8-point star medallion (two overlapping squares rotated 45°).
/// Used for ayah numbers in the Quran reader.
class Star8Medallion extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color? color;
  final Color? fillColor;

  const Star8Medallion({
    super.key,
    this.size = 30,
    this.child,
    this.color,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _Star8Painter(
              color: color ?? Theme.of(context).colorScheme.primary,
              fillColor: fillColor,
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}

class _Star8Painter extends CustomPainter {
  final Color color;
  final Color? fillColor;

  _Star8Painter({required this.color, this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final side = size.width * 0.7;

    final strokePaint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = fillColor != null
        ? (Paint()
            ..color = fillColor!
            ..style = PaintingStyle.fill)
        : null;

    // Square 1 (straight)
    final rect1 = Rect.fromCenter(
      center: Offset(cx, cy),
      width: side,
      height: side,
    );

    // Square 2 (rotated 45°)
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(pi / 4);
    canvas.translate(-cx, -cy);

    if (fillPaint != null) {
      canvas.drawRect(rect1, fillPaint);
    }
    canvas.drawRect(rect1, strokePaint);
    canvas.restore();

    if (fillPaint != null) {
      canvas.drawRect(rect1, fillPaint);
    }
    canvas.drawRect(rect1, strokePaint);
  }

  @override
  bool shouldRepaint(_Star8Painter old) =>
      old.color != color || old.fillColor != fillColor;
}

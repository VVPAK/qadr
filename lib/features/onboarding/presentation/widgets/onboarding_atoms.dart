import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../app/theme.dart';

const _cream = QadrColors.cream;
const _ink = QadrColors.text;

/// Row of progress dots anchored above the CTA.
class OnbDots extends StatelessWidget {
  final int total;
  final int current;

  const OnbDots({super.key, this.total = 5, required this.current});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 138,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (i) {
          final active = i == current;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: QadrSpacing.xs),
            width: active ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: _cream.withValues(alpha: active ? 0.95 : 0.32),
              borderRadius: QadrRadius.pillAll,
            ),
          );
        }),
      ),
    );
  }
}

/// Primary / secondary onboarding call-to-action anchored near the bottom.
class OnbCTA extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool primary;
  final double bottom;

  const OnbCTA({
    super.key,
    required this.label,
    required this.onTap,
    this.primary = true,
    this.bottom = 58,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 28,
      right: 28,
      bottom: bottom,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: QadrSpacing.lg,
            vertical: 15,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primary
                ? _cream.withValues(alpha: 0.96)
                : Colors.transparent,
            borderRadius: QadrRadius.pillAll,
            border: primary
                ? null
                : Border.all(color: _cream.withValues(alpha: 0.28)),
            boxShadow: primary
                ? [
                    BoxShadow(
                      color: const Color(0xFF0A0602).withValues(alpha: 0.28),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primary ? _ink : _cream.withValues(alpha: 0.9),
              fontFamily: 'GeneralSans',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              letterSpacing: -0.15,
            ),
          ),
        ),
      ),
    );
  }
}

/// Pair of stacked CTAs (primary + secondary) — used on permission steps.
class OnbCTAStack extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;

  const OnbCTAStack({
    super.key,
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 28,
      right: 28,
      bottom: 58,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onPrimary,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: QadrSpacing.lg,
                vertical: 15,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _cream.withValues(alpha: 0.96),
                borderRadius: QadrRadius.pillAll,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0A0602).withValues(alpha: 0.28),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Text(
                primaryLabel,
                style: const TextStyle(
                  color: _ink,
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: -0.15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onSecondary,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              alignment: Alignment.center,
              child: Text(
                secondaryLabel,
                style: TextStyle(
                  color: _cream.withValues(alpha: 0.7),
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Uppercase tracked caption — used as eyebrow/step-label on each screen.
class OnbEyebrow extends StatelessWidget {
  final String text;
  final double opacity;

  const OnbEyebrow({super.key, required this.text, this.opacity = 0.62});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: _cream.withValues(alpha: opacity),
        fontFamily: 'GeneralSans',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.2, // 0.2em-ish at 11px
      ),
    );
  }
}

/// Wordmark used on Welcome — thin 8-point star glyph + "Qadr" in Fraunces italic.
class OnbMark extends StatelessWidget {
  const OnbMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.75,
          child: CustomPaint(
            size: const Size(16, 16),
            painter: _StarGlyphPainter(color: _cream),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Qadr',
          style: QadrTheme.display(
            fontSize: 22,
            letterSpacing: -0.22,
            color: _cream,
          ),
        ),
      ],
    );
  }
}

class _StarGlyphPainter extends CustomPainter {
  final Color color;
  _StarGlyphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final side = size.width * 0.72;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeJoin = StrokeJoin.round;

    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: side,
      height: side,
    );

    canvas.drawRect(rect, paint);

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(3.141592653589793 / 4);
    canvas.translate(-cx, -cy);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_StarGlyphPainter old) => old.color != color;
}

/// Display-font hero headline ("Спутник / вашего дня") — two lines, the
/// second typically rendered in italic.
class OnbHeadline extends StatelessWidget {
  final String line1;
  final String line2;
  final double fontSize;

  const OnbHeadline({
    super.key,
    required this.line1,
    required this.line2,
    this.fontSize = 38,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$line1\n',
            style: QadrTheme.display(
              fontSize: fontSize,
              fontStyle: FontStyle.normal,
              color: _cream,
            ).copyWith(height: 1.08),
          ),
          TextSpan(
            text: line2,
            style: QadrTheme.display(
              fontSize: fontSize,
              fontStyle: FontStyle.italic,
              color: _cream,
            ).copyWith(height: 1.08),
          ),
        ],
      ),
    );
  }
}

/// Thin blurred glass pill — used for the RU/EN/AR locale toggle on Welcome.
class OnbGlassPill extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const OnbGlassPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(QadrSpacing.xs),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: QadrRadius.pillAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: const Color(0xFF14100C).withValues(alpha: 0.32),
            borderRadius: QadrRadius.pillAll,
            border: Border.all(color: _cream.withValues(alpha: 0.12)),
          ),
          child: child,
        ),
      ),
    );
  }
}

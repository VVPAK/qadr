import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/widgets/scene_background.dart';
import '../../../../core/widgets/scene_page.dart';
import 'onboarding_atoms.dart';

class OnboardingBismillahStep extends ConsumerStatefulWidget {
  final Future<void> Function() onComplete;

  const OnboardingBismillahStep({super.key, required this.onComplete});

  @override
  ConsumerState<OnboardingBismillahStep> createState() =>
      _OnboardingBismillahStepState();
}

class _OnboardingBismillahStepState
    extends ConsumerState<OnboardingBismillahStep> {
  String? _name;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await ref.read(userPreferencesProvider.future);
    if (!mounted) return;
    setState(() => _name = prefs.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final topPadding = MediaQuery.of(context).padding.top;

    final eyebrowText = (_name ?? '').trim().isEmpty
        ? l10n.onboardingBismillahReady
        : l10n.onboardingBismillahReadyWithName(_name!.trim());

    return ScenePage(
      scene: SceneType.dawn,
      topGradientStrength: 0.38,
      children: [
        Positioned(
          top: topPadding + 64,
          left: 0,
          right: 0,
          child: OnbEyebrow(text: eyebrowText),
        ),

        // Large 8-point star mark
        Positioned(
          top: topPadding + 122,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: 84,
              height: 84,
              child: CustomPaint(painter: _BigStarPainter()),
            ),
          ),
        ),

        // Ceremonial arabic bismillah
        Positioned(
          top: topPadding + 246,
          left: 0,
          right: 0,
          child: Text(
            l10n.onboardingBismillahArabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: QadrTheme.arabic(
              fontSize: 32,
              height: 1.3,
              color: QadrColors.cream,
            ),
          ),
        ),

        // Translation
        Positioned(
          top: topPadding + 316,
          left: 32,
          right: 32,
          child: Text(
            l10n.onboardingBismillahTranslation,
            textAlign: TextAlign.center,
            style: QadrTheme.display(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: QadrColors.cream.withValues(alpha: 0.78),
            ).copyWith(height: 1.55),
          ),
        ),

        // Closing headline
        Positioned(
          top: topPadding + 382,
          left: 32,
          right: 32,
          child: OnbHeadline(
            line1: l10n.onboardingBismillahHeadline1,
            line2: l10n.onboardingBismillahHeadline2,
            fontSize: 30,
          ),
        ),

        const OnbDots(current: 4),
        OnbCTA(
          label: l10n.onboardingBismillahCta,
          onTap: () => widget.onComplete(),
        ),
      ],
    );
  }
}

class _BigStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final outerSide = size.width * 0.666; // 56/84
    final innerSide = size.width * 0.428; // 36/84

    final outerPaint = Paint()
      ..color = QadrColors.cream.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..strokeJoin = StrokeJoin.round;

    final innerPaint = Paint()
      ..color = QadrColors.cream.withValues(alpha: 0.375)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..strokeJoin = StrokeJoin.round;

    void drawStar(double side, Paint paint) {
      final rect = Rect.fromCenter(
        center: Offset(cx, cy),
        width: side,
        height: side,
      );
      canvas.drawRect(rect, paint);
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(0.7853981633974483); // pi/4
      canvas.translate(-cx, -cy);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }

    drawStar(outerSide, outerPaint);
    drawStar(innerSide, innerPaint);
  }

  @override
  bool shouldRepaint(_BigStarPainter old) => false;
}

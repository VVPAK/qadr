import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/services/haptic_service.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';

class _Formula {
  final String id;
  final String ar;
  final String tr;
  final String ru;
  final int target;
  const _Formula(this.id, this.ar, this.tr, this.ru, this.target);
}

const _formulas = [
  _Formula('subhan', 'سُبْحَانَ ٱللَّٰه', 'СубханАллах', 'Пречист Аллах', 33),
  _Formula('hamd', 'ٱلْحَمْدُ لِلَّٰه', 'АльхамдулиЛлях', 'Хвала Аллаху', 33),
  _Formula('akbar', 'ٱللَّٰهُ أَكْبَر', 'АллахуАкбар', 'Аллах Велик', 34),
  _Formula(
    'la',
    'لَا إِلَٰهَ إِلَّا ٱللَّٰه',
    'Ля иляха илля Ллах',
    'Нет бога, кроме Аллаха',
    100,
  ),
];

class DhikrScreen extends ConsumerStatefulWidget {
  final ValueChanged<NavSection> onNavChanged;
  const DhikrScreen({super.key, required this.onNavChanged});

  @override
  ConsumerState<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends ConsumerState<DhikrScreen>
    with SingleTickerProviderStateMixin {
  int _idx = 0;
  final Map<String, int> _counts = {};

  late final AnimationController _bounceCtrl;
  late final Animation<double> _scaleAnim;

  _Formula get _formula => _formulas[_idx];
  int get _count => _counts[_formula.id] ?? 0;
  double get _pct => (_count / _formula.target).clamp(0.0, 1.0);
  bool get _done => _count >= _formula.target;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.1,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 65,
      ),
    ]).animate(_bounceCtrl);
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  void _tap() {
    setState(() {
      _counts[_formula.id] = _count + 1;
    });
    _bounceCtrl.forward(from: 0);

    final haptic = ref.read(hapticServiceProvider);
    if (_count == _formula.target) {
      haptic.success();
    } else {
      haptic.lightImpact();
    }
  }

  void _reset() => setState(() => _counts[_formula.id] = 0);

  @override
  Widget build(BuildContext context) {
    return ScenePage(
      scene: SceneType.dawn,
      topGradientStrength: 0.3,
      children: [
        Positioned.fill(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: QadrSpacing.screenH + 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  _buildFormulaSelector(),
                  const SizedBox(height: 12),
                  _buildFormulaCard(),
                  Expanded(
                    child: GestureDetector(
                      onTap: _tap,
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: LayoutBuilder(
                          builder: (ctx, constraints) {
                            final size = math.min(
                              math.min(
                                constraints.maxWidth * 0.85,
                                constraints.maxHeight * 0.88,
                              ),
                              280.0,
                            );
                            return _buildCounterRing(size);
                          },
                        ),
                      ),
                    ),
                  ),
                  _buildFooterRow(),
                  const SizedBox(height: 110),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormulaSelector() {
    return ClipRRect(
      borderRadius: QadrRadius.pillAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(QadrSpacing.xs),
          decoration: BoxDecoration(
            color: const Color(0x52140C0C),
            borderRadius: QadrRadius.pillAll,
            border: Border.all(color: const Color(0x1FFFFFFF)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_formulas.length, (i) {
                final isActive = i == _idx;
                return GestureDetector(
                  onTap: () => setState(() => _idx = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: QadrRadius.pillAll,
                      color: isActive
                          ? const Color(0xF2F4EFE6)
                          : Colors.transparent,
                    ),
                    child: Text(
                      _formulas[i].tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? const Color(0xFF2A2420)
                            : const Color(0xD1F4EFE6),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormulaCard() {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: QadrSpacing.screenH,
        vertical: 18,
      ),
      borderRadius: 18,
      backgroundOpacity: 0.38,
      child: Column(
        children: [
          Text(
            _formula.ar,
            style: GoogleFonts.amiri(
              fontSize: 30,
              height: 1.8,
              color: const Color(0xFFF4EFE6),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            _formula.tr,
            style: QadrTheme.display(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xD1F4EFE6),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            _formula.ru,
            style: const TextStyle(fontSize: 12, color: Color(0x8CF4EFE6)),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRing(double size) {
    final counterColor = _done
        ? const Color(0xFFFFD88A)
        : const Color(0xFFF4EFE6);
    final subtleColor = _done
        ? const Color(0xFFFFD88A).withValues(alpha: 0.7)
        : const Color(0xB3F4EFE6);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ProgressRingPainter(pct: _pct, done: _done),
          ),
          AnimatedBuilder(
            animation: _scaleAnim,
            builder: (_, child) =>
                Transform.scale(scale: _scaleAnim.value, child: child),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style:
                      QadrTheme.numeral(
                        fontSize: (size * 0.325).clamp(64.0, 96.0),
                        fontWeight: FontWeight.w300,
                        color: counterColor,
                      ).copyWith(
                        height: 1,
                        letterSpacing: -3,
                        shadows: const [
                          Shadow(
                            color: Color(0x40000000),
                            blurRadius: 18,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                  child: Text('$_count'),
                ),
                const SizedBox(height: 10),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: subtleColor,
                  ),
                  child: Text(context.l10n.ofTarget(_formula.target)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFooterButton(context.l10n.reset, onTap: _reset),
        _buildFooterButton(context.l10n.history),
      ],
    );
  }

  Widget _buildFooterButton(String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: QadrRadius.pillAll,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x59140C0C),
              borderRadius: QadrRadius.pillAll,
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xBFF4EFE6)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double pct;
  final bool done;
  _ProgressRingPainter({required this.pct, required this.done});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Background ring
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0x38F4EFE6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * pct,
      false,
      Paint()
        ..color = done ? const Color(0xFFFFD88A) : const Color(0xFFF4EFE6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    // 8-point star motif in center
    final starPaint = Paint()
      ..color = done
          ? const Color(0xFFFFD88A).withValues(alpha: 0.25)
          : const Color(0x1FF4EFE6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    const s = 50.0;
    final rect = Rect.fromCenter(center: center, width: s, height: s);
    canvas.drawRect(rect, starPaint);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(math.pi / 4);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawRect(rect, starPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ProgressRingPainter old) =>
      old.pct != pct || old.done != done;
}

import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
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
  _Formula(
      'hamd', 'ٱلْحَمْدُ لِلَّٰه', 'АльхамдулиЛлях', 'Хвала Аллаху', 33),
  _Formula('akbar', 'ٱللَّٰهُ أَكْبَر', 'АллахуАкбар', 'Аллах Велик', 34),
  _Formula('la', 'لَا إِلَٰهَ إِلَّا ٱللَّٰه', 'Ля иляха илля Ллах',
      'Нет бога, кроме Аллаха', 100),
];

class DhikrScreen extends ConsumerStatefulWidget {
  final ValueChanged<NavSection> onNavChanged;
  const DhikrScreen({super.key, required this.onNavChanged});

  @override
  ConsumerState<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends ConsumerState<DhikrScreen> {
  int _idx = 0;
  final Map<String, int> _counts = {};

  _Formula get _formula => _formulas[_idx];
  int get _count => _counts[_formula.id] ?? 0;
  double get _pct => (_count / _formula.target).clamp(0.0, 1.0);

  void _tap() {
    setState(() {
      _counts[_formula.id] = _count + 1;
    });

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
    final topPadding = MediaQuery.of(context).padding.top;

    return ScenePage(
      scene: SceneType.dawn,
      topGradientStrength: 0.3,
      children: [
        // Formula selector
        Positioned(
          top: topPadding + 10,
          left: 20,
          right: 20,
          child: _buildFormulaSelector(),
        ),

        // Formula text card
        Positioned(
          top: topPadding + 86,
          left: 28,
          right: 28,
          child: _buildFormulaCard(),
        ),

        // Tap zone with counter
        Positioned(
          left: 0,
          right: 0,
          top: topPadding + 250,
          bottom: 145,
          child: GestureDetector(
            onTap: _tap,
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress ring
                    CustomPaint(
                      size: const Size(300, 300),
                      painter: _ProgressRingPainter(pct: _pct),
                    ),

                    // Counter number
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_count',
                          style: QadrTheme.numeral(
                            fontSize: 92,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFFF4EFE6),
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
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'из ${_formula.target}',
                          style: const TextStyle(
                            fontSize: 11,
                            letterSpacing: 2,
                            color: Color(0xB3F4EFE6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Footer actions
        Positioned(
          left: 30,
          right: 30,
          bottom: 145,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterButton('Сбросить', onTap: _reset),
              _buildFooterButton('История'),
            ],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: QadrSpacing.screenH, vertical: 18),
      borderRadius: 18,
      backgroundOpacity: 0.38,
      child: Column(
        children: [
          Text(
            _formula.ar,
            style: GoogleFonts.amiri(
              fontSize: 30,
              height: 1.4,
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
            style: const TextStyle(
              fontSize: 12,
              color: Color(0x8CF4EFE6),
            ),
          ),
        ],
      ),
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
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xBFF4EFE6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double pct;
  _ProgressRingPainter({required this.pct});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 120.0;

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
        ..color = const Color(0xFFF4EFE6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );

    // Subtle 8-point star motif in center
    final starPaint = Paint()
      ..color = const Color(0x1FF4EFE6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    const s = 50.0;
    final rect =
        Rect.fromCenter(center: center, width: s, height: s);
    canvas.drawRect(rect, starPaint);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(math.pi / 4);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawRect(rect, starPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ProgressRingPainter old) => old.pct != pct;
}

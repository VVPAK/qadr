import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/services/location_service.dart';
import '../../../chat/domain/chat_component.dart';
import '../../domain/qibla_providers.dart';
import '../../domain/qibla_service.dart';

import '../../../../app/theme.dart';

class QiblaCompassWidget extends ConsumerStatefulWidget with ChatComponent {
  const QiblaCompassWidget({super.key});

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'qibla',
      };

  @override
  ConsumerState<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends ConsumerState<QiblaCompassWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _locating = false;

  Future<void> _requestLocation() async {
    setState(() => _locating = true);
    final prefs = await ref.read(userPreferencesProvider.future);
    await ref.read(locationServiceProvider).requestAndFetchPosition(prefs);
    if (!mounted) return;
    setState(() => _locating = false);
    ref.invalidate(userPreferencesProvider);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final readingAsync = ref.watch(qiblaReadingProvider);

    return readingAsync.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(QadrSpacing.md),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(context.l10n.errorWithMessage(e.toString())),
        ),
      ),
      data: (reading) {
        if (reading == null) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined, size: 36),
                  const SizedBox(height: QadrSpacing.sm),
                  Text(context.l10n.qiblaLocationRequired,
                      style: context.textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _locating ? null : _requestLocation,
                    child: _locating
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(context.l10n.enableLocation),
                  ),
                ],
              ),
            ),
          );
        }
        return _CompassCard(reading: reading);
      },
    );
  }
}

class _CompassCard extends ConsumerWidget {
  const _CompassCard({required this.reading});
  final QiblaReading reading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compassAsync = ref.watch(compassEventsProvider);
    final heading = compassAsync.maybeWhen(
      data: (e) => e?.heading ?? 0,
      orElse: () => 0.0,
    );
    final needleAngle = reading.magneticBearing - heading;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              context.l10n.qibla,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: QadrSpacing.md),
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -heading * math.pi / 180,
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: _CompassPainter(
                        color: context.colorScheme.outlineVariant,
                        directions: [
                          context.l10n.compassN,
                          context.l10n.compassE,
                          context.l10n.compassS,
                          context.l10n.compassW,
                        ],
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: needleAngle * math.pi / 180,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.navigation,
                          color: context.colorScheme.primary,
                          size: 40,
                        ),
                        const SizedBox(height: QadrSpacing.xs),
                        Text(
                          context.l10n.kaaba,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: QadrSpacing.sm),
            Text(
              '${reading.bearing.toStringAsFixed(1)}°',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({required this.color, required this.directions});
  final Color color;
  final List<String> directions;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, paint);

    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2 - math.pi / 2;
      final textPainter = TextPainter(
        text: TextSpan(
          text: directions[i],
          style: TextStyle(color: color, fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final offset = Offset(
        center.dx + (radius - 20) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius - 20) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(_CompassPainter old) =>
      old.color != color || old.directions != directions;
}

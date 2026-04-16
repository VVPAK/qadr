import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';

class QiblaCompassWidget extends ConsumerStatefulWidget {
  const QiblaCompassWidget({super.key});

  @override
  ConsumerState<QiblaCompassWidget> createState() => _QiblaCompassWidgetState();
}

class _QiblaCompassWidgetState extends ConsumerState<QiblaCompassWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  double _calculateQiblaDirection(double lat, double lng) {
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
  Widget build(BuildContext context) {
    super.build(context);
    final prefsAsync = ref.watch(userPreferencesProvider);

    return prefsAsync.when(
      data: (prefs) {
        final lat = prefs.latitude;
        final lng = prefs.longitude;

        if (lat == null || lng == null) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Location required for Qibla compass'),
            ),
          );
        }

        final qiblaDirection = _calculateQiblaDirection(lat, lng);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  context.l10n.qibla,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: StreamBuilder<CompassEvent>(
                    stream: FlutterCompass.events,
                    builder: (context, snapshot) {
                      final heading = snapshot.data?.heading ?? 0;
                      final direction = qiblaDirection - heading;

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Compass background
                          Transform.rotate(
                            angle: -heading * math.pi / 180,
                            child: CustomPaint(
                              size: const Size(200, 200),
                              painter: _CompassPainter(
                                color: context.colorScheme.outlineVariant,
                              ),
                            ),
                          ),
                          // Qibla indicator
                          Transform.rotate(
                            angle: direction * math.pi / 180,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.navigation,
                                  color: context.colorScheme.primary,
                                  size: 40,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Kaaba',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${qiblaDirection.toStringAsFixed(1)}°',
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error: $e'),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, paint);

    // Draw cardinal directions
    const directions = ['N', 'E', 'S', 'W'];
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

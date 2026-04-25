import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/preferences_provider.dart';
import 'qibla_service.dart';

final qiblaServiceProvider = Provider<QiblaService>(
  (_) => const QiblaService(),
);

final qiblaReadingProvider = FutureProvider<QiblaReading?>((ref) async {
  final prefs = await ref.watch(userPreferencesProvider.future);
  final lat = prefs.latitude;
  final lng = prefs.longitude;
  if (lat == null || lng == null) return null;
  final service = ref.watch(qiblaServiceProvider);
  return QiblaReading(
    bearing: service.calculateBearing(lat, lng),
    declination: service.calculateDeclination(lat, lng),
  );
});

final compassEventsProvider = StreamProvider<CompassEvent?>((ref) {
  return FlutterCompass.events ?? const Stream<CompassEvent?>.empty();
});

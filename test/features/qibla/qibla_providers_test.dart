import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/qibla/domain/qibla_providers.dart';
import 'package:qadr/features/qibla/domain/qibla_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('qibla providers', () {
    test('qiblaServiceProvider creates a QiblaService', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(container.read(qiblaServiceProvider), isA<QiblaService>());
    });

    test('qiblaReadingProvider returns null when no location is stored', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final result = await container.read(qiblaReadingProvider.future);
      expect(result, isNull);
    });

    test('qiblaReadingProvider returns QiblaReading when location is available', () async {
      SharedPreferences.setMockInitialValues({
        'latitude': 21.4225,
        'longitude': 39.8262,
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final result = await container.read(qiblaReadingProvider.future);
      expect(result, isNotNull);
      expect(result!.bearing, greaterThanOrEqualTo(0));
      expect(result.bearing, lessThan(360));
    });
  });
}

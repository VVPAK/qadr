@Tags(['golden'])
library;

import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/features/qibla/domain/qibla_providers.dart';
import 'package:qadr/features/qibla/domain/qibla_service.dart';
import 'package:qadr/features/qibla/presentation/qibla_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/golden_test_helpers.dart';

/// Fixed reading for Kazan (55.79°N, 49.12°E): ~197° from true north.
const _kReading = QiblaReading(bearing: 197.3, declination: 11.2);

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({
      'latitude': 55.79,
      'longitude': 49.12,
      'cityName': 'Kazan',
    });
  });

  goldenTest(
    'qibla_screen',
    providerOverrides: [
      userPreferencesProvider.overrideWith((ref) async {
        final prefs = await SharedPreferences.getInstance();
        return UserPreferences(prefs);
      }),
      qiblaReadingProvider.overrideWith((ref) async => _kReading),
      compassEventsProvider.overrideWith(
        (ref) => const Stream<CompassEvent?>.empty(),
      ),
    ],
    builder: (_) => QiblaScreen(onNavChanged: (_) {}),
  );
}

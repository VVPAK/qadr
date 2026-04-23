import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/core/services/clock.dart';
import 'package:qadr/features/prayer/presentation/prayer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/golden_test_helpers.dart';

/// Fixed clock: 2024-04-15 12:00:00 local.
/// Fajr / Sunrise are past; Dhuhr is next — stable for any test environment.
class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2024, 4, 15, 12, 0, 0);
}

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({
      'latitude': 55.79,
      'longitude': 49.12,
      'cityName': 'Kazan',
    });
  });

  goldenTest(
    'prayer_screen',
    providerOverrides: [
      clockProvider.overrideWithValue(_FixedClock()),
      userPreferencesProvider.overrideWith((ref) async {
        final prefs = await SharedPreferences.getInstance();
        return UserPreferences(prefs);
      }),
    ],
    builder: (_) => PrayerScreen(onNavChanged: (_) {}),
  );
}

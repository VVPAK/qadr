@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/features/onboarding/presentation/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  goldenTest(
    'onboarding_screen',
    providerOverrides: [
      userPreferencesProvider.overrideWith((ref) async {
        final prefs = await SharedPreferences.getInstance();
        return UserPreferences(prefs);
      }),
    ],
    builder: (_) => const OnboardingScreen(),
  );
}

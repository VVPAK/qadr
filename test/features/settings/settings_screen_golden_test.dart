@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/providers.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/features/settings/presentation/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  goldenTest(
    'settings_screen',
    providerOverrides: [
      userPreferencesProvider.overrideWith((ref) async {
        final prefs = await SharedPreferences.getInstance();
        return UserPreferences(prefs);
      }),
      localProvider.overrideWith((ref) => const Locale('en')),
    ],
    builder: (_) => const SettingsScreen(),
  );
}

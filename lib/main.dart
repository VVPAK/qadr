import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/data/preferences/user_preferences.dart';
import 'driver_bootstrap.dart';
import 'features/learning/data/learning_progress_store.dart';
import 'features/learning/presentation/providers/learning_provider.dart';

// Compile-time opt-in for Flutter Driver (integration tests only).
// Run with: fvm flutter drive --dart-define=ENABLE_DRIVER=true ...
const _enableDriver = bool.fromEnvironment('ENABLE_DRIVER');

void main() async {
  if (_enableDriver) enableDriverExtensionIfRequested();
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(prefs);
  final learningStore = LearningProgressStore(prefs);

  // Restore saved language
  final savedLanguage = userPrefs.language;

  runApp(
    ProviderScope(
      overrides: [
        learningProgressProvider.overrideWithValue(learningStore),
        localProvider.overrideWith((ref) => Locale(savedLanguage)),
      ],
      child: const QadrApp(),
    ),
  );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/data/preferences/user_preferences.dart';
import 'features/learning/data/learning_progress_store.dart';
import 'features/learning/presentation/providers/learning_provider.dart';

void main() async {
  if (kDebugMode) {
    enableFlutterDriverExtension();
  }
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

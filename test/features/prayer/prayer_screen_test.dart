import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/core/services/clock.dart';
import 'package:qadr/core/widgets/scene_background.dart';
import 'package:qadr/features/prayer/presentation/prayer_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2024, 4, 15, 12, 0, 0);
}

Future<void> _pump(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({
    'latitude': 55.79,
    'longitude': 49.12,
    'cityName': 'Kazan',
  });
  final sharedPrefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(sharedPrefs);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clockProvider.overrideWithValue(_FixedClock()),
        userPreferencesProvider.overrideWith((_) async => userPrefs),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PrayerScreen(onNavChanged: _noopNav),
      ),
    ),
  );
  // Drain async prefs load; avoid pumpAndSettle — the 1s timer never settles.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void _noopNav(_) {}

SceneType _currentScene(WidgetTester tester) =>
    tester.widget<SceneBackground>(find.byType(SceneBackground).first).scene;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Scene picker', () {
    testWidgets('starts on the first scene (dusk)', (tester) async {
      await _pump(tester);
      expect(_currentScene(tester), SceneType.dusk);
    });

    testWidgets('tapping the picker cycles through all scenes in order and wraps', (
      tester,
    ) async {
      await _pump(tester);

      // The scene picker is the GestureDetector that contains the AnimatedContainers
      // (the dot indicators). After the fix this is a single tap target wrapping the
      // entire pill; we verify the cycle repeats in order.
      final picker = find
          .ancestor(
            of: find.byType(AnimatedContainer).first,
            matching: find.byType(GestureDetector),
          )
          .first;

      expect(_currentScene(tester), SceneType.dusk);

      await tester.tap(picker);
      await tester.pump();
      expect(_currentScene(tester), SceneType.dune);

      await tester.tap(picker);
      await tester.pump();
      expect(_currentScene(tester), SceneType.night);

      await tester.tap(picker);
      await tester.pump();
      expect(_currentScene(tester), SceneType.dawn);

      // Wrap-around back to first.
      await tester.tap(picker);
      await tester.pump();
      expect(_currentScene(tester), SceneType.dusk);
    });
  });
}

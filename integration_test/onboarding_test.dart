import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qadr/app/app.dart';
import 'package:qadr/app/providers.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/core/providers/widget_service_provider.dart';
import 'package:qadr/core/services/location_service.dart';
import 'package:qadr/core/widgets/floating_nav_bar.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Stub that grants access and writes Mecca coordinates — no real GPS call.
class _FakeLocationService extends LocationService {
  @override
  Future<bool> requestAndFetchPosition(UserPreferences prefs) async {
    prefs.latitude = 21.4225;
    prefs.longitude = 39.8262;
    prefs.cityName = 'Mecca';
    return true;
  }

  @override
  Future<String?> resolveCityName(
    double lat,
    double lng,
    UserPreferences prefs,
  ) async =>
      'Mecca';
}

/// Advances the clock in 8 × 100 ms slices — same budget as the widget tests.
/// Avoids pumpAndSettle which never settles while a text cursor blinks.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Boots the app with:
///  - fresh SharedPreferences (no onboarding state)
///  - fake GPS (no real permission dialog)
///  - null WidgetService (no home-widget update calls)
///  - fixed English locale
Future<void> _launchApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final sharedPrefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(sharedPrefs);
  final learningStore = LearningProgressStore(sharedPrefs);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        userPreferencesProvider.overrideWith((_) async => userPrefs),
        locationServiceProvider.overrideWithValue(_FakeLocationService()),
        widgetServiceProvider.overrideWithValue(null),
        learningProgressProvider.overrideWithValue(learningStore),
        localProvider.overrideWith((_) => const Locale('en')),
      ],
      child: const QadrApp(),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding integration', () {
    testWidgets('happy path: walks all steps and lands on main shell',
        (tester) async {
      await _launchApp(tester);

      // ── Step 1: Welcome ──────────────────────────────────────────────────
      expect(find.text('Begin'), findsOneWidget);

      await tester.tap(find.text('Begin'));
      await _settle(tester);

      // ── Step 2: Name ─────────────────────────────────────────────────────
      expect(find.byType(TextField), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Aisha');
      await tester.tap(find.text('Next'));
      await _settle(tester);

      // ── Step 3: Location ─────────────────────────────────────────────────
      expect(find.text('Allow access'), findsOneWidget);

      await tester.tap(find.text('Allow access'));
      await _settle(tester);

      // ── Step 4: Notifications ────────────────────────────────────────────
      expect(find.text('Enable reminders'), findsOneWidget);

      await tester.tap(find.text('Enable reminders'));
      await _settle(tester);

      // ── Step 5: Bismillah ────────────────────────────────────────────────
      expect(find.text('Enter Qadr'), findsOneWidget);

      await tester.tap(find.text('Enter Qadr'));
      await _settle(tester);

      // ── Main shell ───────────────────────────────────────────────────────
      expect(find.byType(FloatingNavBar), findsOneWidget);
    });

    testWidgets('skipping name and location still completes onboarding',
        (tester) async {
      await _launchApp(tester);

      await tester.tap(find.text('Begin'));
      await _settle(tester);

      // Skip name (empty field)
      await tester.tap(find.text('Next'));
      await _settle(tester);

      // Skip location
      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);

      // Decline notifications
      await tester.tap(find.text('Not now'));
      await _settle(tester);

      await tester.tap(find.text('Enter Qadr'));
      await _settle(tester);

      expect(find.byType(FloatingNavBar), findsOneWidget);
    });

    testWidgets('onboarding is skipped on relaunch after completion',
        (tester) async {
      // Pre-seed SharedPreferences with onboarding already done.
      SharedPreferences.setMockInitialValues({
        'onboarding_complete': true,
      });
      final sharedPrefs = await SharedPreferences.getInstance();
      final userPrefs = UserPreferences(sharedPrefs);
      final learningStore = LearningProgressStore(sharedPrefs);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userPreferencesProvider.overrideWith((_) async => userPrefs),
            locationServiceProvider.overrideWithValue(_FakeLocationService()),
            widgetServiceProvider.overrideWithValue(null),
            learningProgressProvider.overrideWithValue(learningStore),
            localProvider.overrideWith((_) => const Locale('en')),
          ],
          child: const QadrApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      // Wait for userPreferencesProvider to resolve so RouterListenable fires
      // and GoRouter redirects from /onboarding → /.
      await _settle(tester);

      // Should land directly on main shell — no "Begin" button.
      expect(find.text('Begin'), findsNothing);
      expect(find.byType(FloatingNavBar), findsOneWidget);
    });

    testWidgets('language selection on welcome step persists to the app',
        (tester) async {
      await _launchApp(tester);

      await tester.tap(find.text('RU'));
      await _settle(tester);

      await tester.tap(find.text('Начать знакомство'));
      await _settle(tester);

      // Name step should now be in Russian
      expect(find.text('Далее'), findsOneWidget);
    });
  });
}

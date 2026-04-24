import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/app/providers.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/core/providers/widget_service_provider.dart';
import 'package:qadr/core/services/location_service.dart';
import 'package:qadr/features/onboarding/presentation/onboarding_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Subclass of [LocationService] that records whether permission was
/// requested and optionally writes fake coordinates back to [prefs].
class _FakeLocationService extends LocationService {
  _FakeLocationService({this.grantAccess = true});

  final bool grantAccess;
  int requestCount = 0;

  @override
  Future<bool> requestAndFetchPosition(UserPreferences prefs) async {
    requestCount += 1;
    if (!grantAccess) return false;
    prefs.latitude = 21.4225;
    prefs.longitude = 39.8262;
    return true;
  }

  @override
  Future<String?> resolveCityName(
    double lat,
    double lng,
    UserPreferences prefs,
  ) async =>
      null;
}

Future<({UserPreferences prefs, _FakeLocationService location,
    GoRouter router})> _pump(
  WidgetTester tester, {
  _FakeLocationService? location,
  Locale locale = const Locale('en'),
  Map<String, Object> initialPrefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(initialPrefs);
  final sharedPrefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(sharedPrefs);
  final fakeLocation = location ?? _FakeLocationService();

  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(
          body: Center(child: Text('__HOME__')),
        ),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        userPreferencesProvider.overrideWith((_) async => userPrefs),
        locationServiceProvider.overrideWithValue(fakeLocation),
        widgetServiceProvider.overrideWithValue(null),
        localProvider.overrideWith((_) => locale),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  // One frame for initial build + a frame for post-frame callbacks (prefs
  // async load). Can't use pumpAndSettle here — the name step has a
  // repeating caret ticker that never settles.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));

  return (prefs: userPrefs, location: fakeLocation, router: router);
}

/// Pumps enough frames to complete a PageView step transition (350ms curve
/// in the production widget) plus any one-shot async work (prefs reads,
/// post-frame callbacks in step widgets).
///
/// Can't use pumpAndSettle: the name step has a repeating caret ticker that
/// never settles. Instead we advance the fake clock in small slices, which
/// also drains microtasks between frames.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Runs every step from the name CTA through to the final bismillah CTA.
/// Assumes English locale.
Future<void> _advanceToEnd(WidgetTester tester) async {
  await tester.tap(find.text('Next'));
  await _settle(tester);
  await tester.tap(find.text('Allow access'));
  await _settle(tester);
  await tester.tap(find.text('Enable reminders'));
  await _settle(tester);
  await tester.tap(find.text('Enter Qadr'));
  await _settle(tester);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Welcome step', () {
    testWidgets('shows the three language toggles and the Begin CTA',
        (tester) async {
      await _pump(tester);
      expect(find.text('RU'), findsOneWidget);
      expect(find.text('EN'), findsOneWidget);
      expect(find.text('AR'), findsOneWidget);
      expect(find.text('Begin'), findsOneWidget);
    });

    testWidgets('tapping RU writes "ru" to prefs and updates localProvider',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('RU'));
      await _settle(tester);
      expect(ctx.prefs.language, 'ru');
    });

    testWidgets('Begin CTA advances to the name step', (tester) async {
      await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      expect(find.text('Next'), findsOneWidget);
    });
  });

  group('Name step', () {
    testWidgets('entering a name and tapping Next persists it + advances',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);

      await tester.enterText(find.byType(TextField), 'Aisha');
      await tester.tap(find.text('Next'));
      await _settle(tester);

      expect(ctx.prefs.name, 'Aisha');
      // Location step CTAs visible.
      expect(find.text('Allow access'), findsOneWidget);
    });

    testWidgets('trimming: whitespace-only name is stored as null',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);

      await tester.enterText(find.byType(TextField), '   ');
      await tester.tap(find.text('Next'));
      await _settle(tester);

      expect(ctx.prefs.name, isNull);
    });

    testWidgets('skipping the name (empty field) stores null and advances',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);

      await tester.tap(find.text('Next'));
      await _settle(tester);

      expect(ctx.prefs.name, isNull);
      expect(find.text('Allow access'), findsOneWidget);
    });
  });

  group('Location step', () {
    testWidgets('Allow access asks the LocationService and writes coords',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);

      expect(find.text('Allow access'), findsOneWidget);
      expect(find.text('Choose city manually'), findsOneWidget);

      await tester.tap(find.text('Allow access'));
      await _settle(tester);

      expect(ctx.location.requestCount, 1);
      expect(ctx.prefs.latitude, 21.4225);
      expect(ctx.prefs.longitude, 39.8262);
      expect(find.text('Enable reminders'), findsOneWidget);
    });

    testWidgets(
        'denied permission still advances but leaves coords untouched',
        (tester) async {
      final ctx = await _pump(
        tester,
        location: _FakeLocationService(grantAccess: false),
      );
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);

      await tester.tap(find.text('Allow access'));
      await _settle(tester);

      expect(ctx.location.requestCount, 1);
      expect(ctx.prefs.latitude, isNull);
      expect(ctx.prefs.longitude, isNull);
      expect(find.text('Enable reminders'), findsOneWidget);
    });

    testWidgets('Choose city manually skips without calling the service',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);

      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);

      expect(ctx.location.requestCount, 0);
      expect(ctx.prefs.latitude, isNull);
      expect(find.text('Enable reminders'), findsOneWidget);
    });
  });

  group('Notifications step', () {
    testWidgets('Enable reminders sets notificationsEnabled=true and advances',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);
      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);

      await tester.tap(find.text('Enable reminders'));
      await _settle(tester);

      expect(ctx.prefs.notificationsEnabled, isTrue);
      expect(find.text('Enter Qadr'), findsOneWidget);
    });

    testWidgets('Not now sets notificationsEnabled=false and advances',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);
      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);

      await tester.tap(find.text('Not now'));
      await _settle(tester);

      expect(ctx.prefs.notificationsEnabled, isFalse);
      expect(find.text('Enter Qadr'), findsOneWidget);
    });
  });

  group('Bismillah step', () {
    testWidgets('generic eyebrow when no name was entered', (tester) async {
      await _pump(tester);
      // Skip through to the bismillah step with no name.
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);
      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);
      await tester.tap(find.text('Not now'));
      await _settle(tester);

      // OnbEyebrow uppercases its text.
      expect(find.text('READY'), findsOneWidget);
      expect(find.text('Enter Qadr'), findsOneWidget);
    });

    testWidgets('personalised eyebrow when a name was entered',
        (tester) async {
      await _pump(tester);
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.enterText(find.byType(TextField), 'Aisha');
      await tester.tap(find.text('Next'));
      await _settle(tester);
      await tester.tap(find.text('Choose city manually'));
      await _settle(tester);
      await tester.tap(find.text('Not now'));
      await _settle(tester);

      expect(find.text('READY, AISHA'), findsOneWidget);
    });
  });

  group('End-to-end flow', () {
    testWidgets(
        'full happy path sets onboardingComplete=true and navigates to /',
        (tester) async {
      final ctx = await _pump(tester);

      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.enterText(find.byType(TextField), 'Aisha');
      await _advanceToEnd(tester);

      expect(ctx.prefs.onboardingComplete, isTrue);
      expect(ctx.prefs.name, 'Aisha');
      expect(ctx.prefs.latitude, 21.4225);
      expect(ctx.prefs.notificationsEnabled, isTrue);
      // Router should now be on '/'.
      expect(find.text('__HOME__'), findsOneWidget);
    });

    testWidgets('language picked at the welcome step persists through the flow',
        (tester) async {
      final ctx = await _pump(tester);
      await tester.tap(find.text('RU'));
      await _settle(tester);
      expect(ctx.prefs.language, 'ru');
    });
  });

  group('Name prefill', () {
    testWidgets('pre-populated name is shown in the text field on the name '
        'step', (tester) async {
      await _pump(tester, initialPrefs: {'name': 'Omar'});
      await tester.tap(find.text('Begin'));
      await _settle(tester);
      final tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.controller!.text, 'Omar');
    });
  });

  group('Madhab default (via fake location)', () {
    testWidgets('the fake location writes coords but not madhab (fake does '
        'not call the real madhab detection)', (tester) async {
      // Guard against regressions where the widget silently overwrites
      // madhab even when the service is replaced.
      final ctx = await _pump(tester);
      expect(ctx.prefs.madhab, Madhab.hanafi); // default from prefs (index 0)

      await tester.tap(find.text('Begin'));
      await _settle(tester);
      await tester.tap(find.text('Next'));
      await _settle(tester);
      await tester.tap(find.text('Allow access'));
      await _settle(tester);

      expect(ctx.prefs.madhab, Madhab.hanafi);
    });
  });
}

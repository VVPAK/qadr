import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/app/router.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RouterListenable', () {
    test('starts with onboardingComplete = false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final listenable = RouterListenable.fromContainer(container);
      addTearDown(listenable.dispose);

      expect(listenable.onboardingComplete, isFalse);
    });

    test(
      'notifies and updates flag when onboarding becomes complete',
      () async {
        SharedPreferences.setMockInitialValues({'onboarding_complete': true});
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final listenable = RouterListenable.fromContainer(container);
        addTearDown(listenable.dispose);

        var notified = false;
        listenable.addListener(() => notified = true);

        await container.read(userPreferencesProvider.future);

        expect(listenable.onboardingComplete, isTrue);
        expect(notified, isTrue);
      },
    );

    test(
      'does not notify when onboardingComplete value stays the same',
      () async {
        SharedPreferences.setMockInitialValues({'onboarding_complete': false});
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final listenable = RouterListenable.fromContainer(container);
        addTearDown(listenable.dispose);

        await container.read(userPreferencesProvider.future);

        var notifyCount = 0;
        listenable.addListener(() => notifyCount++);

        // Simulate location being saved — onboarding flag stays false
        SharedPreferences.setMockInitialValues({
          'onboarding_complete': false,
          'latitude': 21.4225,
          'longitude': 39.8262,
        });
        container.invalidate(userPreferencesProvider);
        await container.read(userPreferencesProvider.future);

        expect(notifyCount, 0);
      },
    );

    test(
      'does not notify router when only location changes (onboarding already true)',
      () async {
        SharedPreferences.setMockInitialValues({'onboarding_complete': true});
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final listenable = RouterListenable.fromContainer(container);
        addTearDown(listenable.dispose);

        // First load — captures initial onboarding = true
        await container.read(userPreferencesProvider.future);

        var notifyCount = 0;
        listenable.addListener(() => notifyCount++);

        // Simulate qibla location permission granted (onboarding still true)
        SharedPreferences.setMockInitialValues({
          'onboarding_complete': true,
          'latitude': 21.4225,
          'longitude': 39.8262,
        });
        container.invalidate(userPreferencesProvider);
        await container.read(userPreferencesProvider.future);

        expect(
          notifyCount,
          0,
          reason: 'Router must not refresh when only location changes',
        );
      },
    );
  });

  group('routerProvider', () {
    test('creates a GoRouter instance', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final router = container.read(routerProvider);
      expect(router, isA<GoRouter>());
      container.invalidate(routerProvider);
    });
  });
}

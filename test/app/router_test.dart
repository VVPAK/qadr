import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/router.dart';

void main() {
  group('onboardingRedirect', () {
    test('sends a fresh user on "/" to /onboarding', () {
      expect(
        onboardingRedirect(
          onboardingComplete: false,
          matchedLocation: '/',
        ),
        '/onboarding',
      );
    });

    test('sends a fresh user on a deep link to /onboarding', () {
      expect(
        onboardingRedirect(
          onboardingComplete: false,
          matchedLocation: '/quran/2',
        ),
        '/onboarding',
      );
    });

    test('lets a fresh user stay on /onboarding', () {
      expect(
        onboardingRedirect(
          onboardingComplete: false,
          matchedLocation: '/onboarding',
        ),
        isNull,
      );
    });

    test('bounces a completed user off /onboarding back to /', () {
      expect(
        onboardingRedirect(
          onboardingComplete: true,
          matchedLocation: '/onboarding',
        ),
        '/',
      );
    });

    test('does not interfere with completed users on regular routes', () {
      for (final loc in ['/', '/quran/1', '/settings']) {
        expect(
          onboardingRedirect(
            onboardingComplete: true,
            matchedLocation: loc,
          ),
          isNull,
          reason: 'loc=$loc',
        );
      }
    });
  });
}

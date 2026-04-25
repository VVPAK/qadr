import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/quran/presentation/surah_reader_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../core/data/preferences/user_preferences.dart';
import '../core/providers/preferences_provider.dart';
import 'main_shell.dart';

/// Decides whether the router should redirect based on onboarding state.
///
/// Kept as a top-level pure function so it can be unit-tested without
/// having to instantiate the full GoRouter / MaterialApp stack.
String? onboardingRedirect({
  required bool onboardingComplete,
  required String matchedLocation,
}) {
  final isOnboarding = matchedLocation == '/onboarding';
  if (!onboardingComplete && !isOnboarding) return '/onboarding';
  if (onboardingComplete && isOnboarding) return '/';
  return null;
}

/// Bridges Riverpod preference state to GoRouter's refreshListenable.
///
/// Keeps GoRouter stable (created once) while still re-evaluating redirects
/// when onboarding status changes. Prevents the router from being recreated
/// when unrelated preferences (e.g. location) are updated, which would
/// otherwise reset MainShell's PageView back to the first tab.
class RouterListenable extends ChangeNotifier {
  RouterListenable(Ref ref) {
    ref.listen<AsyncValue<UserPreferences>>(
      userPreferencesProvider,
      (_, next) => _onChanged(next),
    );
  }

  @visibleForTesting
  RouterListenable.fromContainer(ProviderContainer container) {
    _subscription = container.listen<AsyncValue<UserPreferences>>(
      userPreferencesProvider,
      (_, next) => _onChanged(next),
    );
  }

  ProviderSubscription<AsyncValue<UserPreferences>>? _subscription;

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  void _onChanged(AsyncValue<UserPreferences> next) {
    final newVal = next.valueOrNull?.onboardingComplete ?? false;
    if (newVal != _onboardingComplete) {
      _onboardingComplete = newVal;
      notifyListeners();
    }
  }

  bool _onboardingComplete = false;
  bool get onboardingComplete => _onboardingComplete;
}

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = RouterListenable(ref);
  ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) => onboardingRedirect(
      onboardingComplete: listenable.onboardingComplete,
      matchedLocation: state.matchedLocation,
    ),
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainShell(),
      ),
      GoRoute(
        path: '/quran/:surahNumber',
        builder: (context, state) {
          final surahNumber =
              int.parse(state.pathParameters['surahNumber']!);
          final initialAyah =
              int.tryParse(state.uri.queryParameters['ayah'] ?? '');
          return SurahReaderScreen(
            surahNumber: surahNumber,
            initialAyah: initialAyah,
          );
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

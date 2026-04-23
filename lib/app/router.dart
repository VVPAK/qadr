import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/quran/presentation/surah_reader_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../core/providers/preferences_provider.dart';
import 'main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(userPreferencesProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final onboardingComplete =
          prefs.valueOrNull?.onboardingComplete ?? false;
      final isOnboarding = state.matchedLocation == '/onboarding';

      if (!onboardingComplete && !isOnboarding) return '/onboarding';
      if (onboardingComplete && isOnboarding) return '/';
      return null;
    },
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

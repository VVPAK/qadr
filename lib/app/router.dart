import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chat/presentation/chat_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/quran/presentation/quran_reader_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/dua/presentation/dua_list_screen.dart';
import '../core/providers/preferences_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(userPreferencesProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final onboardingComplete = prefs.valueOrNull?.onboardingComplete ?? false;
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
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/quran',
        builder: (context, state) => const QuranReaderScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/dua',
        builder: (context, state) => const DuaListScreen(),
      ),
    ],
  );
});

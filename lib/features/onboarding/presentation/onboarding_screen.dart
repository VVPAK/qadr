import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/preferences_provider.dart';
import 'widgets/onboarding_bismillah_step.dart';
import 'widgets/onboarding_location_step.dart';
import 'widgets/onboarding_name_step.dart';
import 'widgets/onboarding_notifications_step.dart';
import 'widgets/onboarding_welcome_step.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await ref.read(userPreferencesProvider.future);
    prefs.onboardingComplete = true;
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnboardingWelcomeStep(onNext: _nextPage),
          OnboardingNameStep(onNext: _nextPage),
          OnboardingLocationStep(onNext: _nextPage),
          OnboardingNotificationsStep(onNext: _nextPage),
          OnboardingBismillahStep(onComplete: _completeOnboarding),
        ],
      ),
    );
  }
}

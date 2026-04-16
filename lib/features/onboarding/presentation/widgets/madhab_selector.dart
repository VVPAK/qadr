import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/islamic_constants.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../../core/extensions/context_extensions.dart';

class MadhabSelector extends ConsumerWidget {
  const MadhabSelector({super.key, required this.onNext, required this.onBack});
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.onboardingMadhab,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          ...Madhab.values.map((madhab) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final prefs =
                          await ref.read(userPreferencesProvider.future);
                      prefs.madhab = madhab;
                      onNext();
                    },
                    child: Text(
                      madhab.displayName,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/providers/preferences_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key, required this.onNext});
  final VoidCallback onNext;

  static const _languages = [
    ('en', 'English', '🇬🇧'),
    ('ar', 'العربية', '🇸🇦'),
    ('ru', 'Русский', '🇷🇺'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose your language',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          ..._languages.map((lang) {
            final isSelected = currentLocale.languageCode == lang.$1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Text(lang.$3, style: const TextStyle(fontSize: 28)),
                title: Text(lang.$2, style: const TextStyle(fontSize: 18)),
                selected: isSelected,
                selectedTileColor:
                    Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isSelected
                      ? BorderSide(color: Theme.of(context).colorScheme.primary)
                      : BorderSide.none,
                ),
                tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
                onTap: () async {
                  ref.read(localProvider.notifier).state = Locale(lang.$1);
                  final prefs = await ref.read(userPreferencesProvider.future);
                  prefs.language = lang.$1;
                  onNext();
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

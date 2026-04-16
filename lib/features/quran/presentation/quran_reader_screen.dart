import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/data/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import 'providers/quran_providers.dart';

class QuranReaderScreen extends ConsumerWidget {
  const QuranReaderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(surahListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quran),
      ),
      body: surahsAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                context.l10n.loadingQuran,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
        data: (surahs) => ListView.builder(
          itemCount: surahs.length,
          itemBuilder: (context, index) =>
              _SurahListTile(surah: surahs[index]),
        ),
      ),
    );
  }
}

class _SurahListTile extends StatelessWidget {
  const _SurahListTile({required this.surah});
  final Surah surah;

  String _localizedName(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return switch (locale) {
      'ar' => surah.nameArabic,
      'ru' => surah.nameRussian,
      _ => surah.nameEnglish,
    };
  }

  String _localizedRevelationType(BuildContext context) {
    final l10n = context.l10n;
    return surah.revelationType == 'Meccan' ? l10n.meccan : l10n.medinan;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final showArabicTrailing = locale != 'ar';

    return ListTile(
      leading: _SurahNumber(number: surah.number),
      title: Text(_localizedName(context)),
      subtitle: Text(
        '${_localizedRevelationType(context)} · ${context.l10n.ayahCount(surah.ayahCount)}',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: showArabicTrailing
          ? Text(
              surah.nameArabic,
              style: GoogleFonts.amiri(
                fontSize: 18,
                color: context.colorScheme.onSurface,
              ),
              textDirection: TextDirection.rtl,
            )
          : null,
      onTap: () => context.push('/quran/${surah.number}'),
    );
  }
}

class _SurahNumber extends StatelessWidget {
  const _SurahNumber({required this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

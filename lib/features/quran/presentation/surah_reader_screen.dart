import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/data/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../chat/presentation/providers/chat_provider.dart';
import 'providers/quran_providers.dart';

class SurahReaderScreen extends ConsumerWidget {
  const SurahReaderScreen({super.key, required this.surahNumber});
  final int surahNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahAsync = ref.watch(surahProvider(surahNumber));
    final ayahsAsync = ref.watch(ayahsProvider(surahNumber));

    return Scaffold(
      appBar: AppBar(
        title: surahAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
          data: (surah) => Text(_surahTitle(context, surah)),
        ),
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (ayahs) => _AyahListView(
          surahNumber: surahNumber,
          surahName: surahAsync.valueOrNull != null
              ? _surahTitle(context, surahAsync.valueOrNull!)
              : '',
          ayahs: ayahs,
        ),
      ),
    );
  }

  String _surahTitle(BuildContext context, Surah surah) {
    final locale = Localizations.localeOf(context).languageCode;
    return switch (locale) {
      'ar' => surah.nameArabic,
      'ru' => surah.nameRussian,
      _ => surah.nameEnglish,
    };
  }
}

class _AyahListView extends StatelessWidget {
  const _AyahListView({
    required this.surahNumber,
    required this.surahName,
    required this.ayahs,
  });
  final int surahNumber;
  final String surahName;
  final List<Ayah> ayahs;

  bool get _showBismillah => surahNumber != 1 && surahNumber != 9;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: ayahs.length + (_showBismillah ? 1 : 0),
      itemBuilder: (context, index) {
        if (_showBismillah && index == 0) {
          return _BismillahHeader();
        }
        final ayah = ayahs[_showBismillah ? index - 1 : index];
        return _AyahTile(ayah: ayah, surahName: surahName);
      },
    );
  }
}

class _BismillahHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
        style: GoogleFonts.amiri(
          fontSize: 24,
          height: 1.8,
          color: context.colorScheme.primary,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _AyahTile extends ConsumerWidget {
  const _AyahTile({required this.ayah, required this.surahName});
  final Ayah ayah;
  final String surahName;

  String _translation(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return switch (locale) {
      'ar' => '',
      'ru' => ayah.textRussian,
      _ => ayah.textEnglish,
    };
  }

  void _discussInChat(BuildContext context, WidgetRef ref) {
    final translation = _translation(context);
    ref.read(chatMessagesProvider.notifier).discussAyah(
          surahNumber: ayah.surahNumber,
          ayahNumber: ayah.ayahNumber,
          textArabic: ayah.textArabic,
          translation: translation.isNotEmpty ? translation : ayah.textEnglish,
          surahName: surahName,
        );
    context.go('/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = _translation(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ayah number badge + discuss button
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    '${ayah.ayahNumber}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 20),
                tooltip: context.l10n.discussInChat,
                onPressed: () => _discussInChat(context, ref),
                visualDensity: VisualDensity.compact,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Arabic text
          Text(
            ayah.textArabic,
            style: GoogleFonts.amiri(
              fontSize: 24,
              height: 2.0,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          if (translation.isNotEmpty) ...[
            const SizedBox(height: 12),
            // Translation
            Text(
              translation,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

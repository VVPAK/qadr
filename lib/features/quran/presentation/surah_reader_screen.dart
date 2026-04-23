import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../app/theme.dart';
import '../../../core/data/database/app_database.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/scene_page.dart';
import '../../../core/widgets/star8_medallion.dart';
import 'providers/quran_providers.dart';

class SurahReaderScreen extends ConsumerWidget {
  const SurahReaderScreen({
    super.key,
    required this.surahNumber,
    this.initialAyah,
  });
  final int surahNumber;
  final int? initialAyah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahAsync = ref.watch(surahProvider(surahNumber));
    final ayahsAsync = ref.watch(ayahsProvider(surahNumber));

    return Scaffold(
      body: ParchmentPage(
        activeNav: NavSection.quran,
        onNavChanged: (section) {
          context.go('/');
          // Navigation will be handled by MainShell
        },
        children: [
          // Header bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context, surahAsync),
          ),

          // Content
          Positioned(
            top: MediaQuery.of(context).padding.top + 56,
            left: 0,
            right: 0,
            bottom: 0,
            child: ayahsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (ayahs) => _AyahListView(
                surahNumber: surahNumber,
                ayahs: ayahs,
                initialAyah: initialAyah,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AsyncValue<Surah> surahAsync) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 10,
        left: 18,
        right: 18,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.94),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.chevron_left,
                size: 24,
                color: QadrColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: surahAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (surah) => Column(
                children: [
                  Text(
                    _surahTitle(context, surah),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'сура ${surah.number} · ${surah.revelationType == 'Meccan' ? 'мекканская' : 'мединская'}',
                    style: TextStyle(
                      fontSize: 11,
                      color: QadrColors.textFaint,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 36), // Balance the back button
        ],
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

class _AyahListView extends StatefulWidget {
  const _AyahListView({
    required this.surahNumber,
    required this.ayahs,
    this.initialAyah,
  });
  final int surahNumber;
  final List<Ayah> ayahs;
  final int? initialAyah;

  @override
  State<_AyahListView> createState() => _AyahListViewState();
}

class _AyahListViewState extends State<_AyahListView> {
  final _itemScrollController = ItemScrollController();
  int? _highlightedAyah;
  final bool _showTranslation = true;

  bool get _showBismillah => widget.surahNumber != 1 && widget.surahNumber != 9;

  int get _initialIndex {
    final ayah = widget.initialAyah;
    if (ayah == null) return 0;
    final ayahIndex = ayah - 1;
    return ayahIndex + (_showBismillah ? 1 : 0);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialAyah != null) {
      _highlightedAyah = widget.initialAyah;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _highlightedAyah = null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      initialScrollIndex: _initialIndex,
      padding: const EdgeInsets.fromLTRB(26, 22, 26, 150),
      itemCount: widget.ayahs.length + (_showBismillah ? 1 : 0),
      itemBuilder: (context, index) {
        if (_showBismillah && index == 0) {
          return _BismillahHeader();
        }
        final ayah = widget.ayahs[_showBismillah ? index - 1 : index];
        return _AyahTile(
          ayah: ayah,
          showTranslation: _showTranslation,
          isHighlighted: _highlightedAyah == ayah.ayahNumber,
        );
      },
    );
  }
}

class _BismillahHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Text(
            'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
            style: GoogleFonts.amiri(
              fontSize: 26,
              height: 1.8,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Во имя Аллаха, Милостивого, Милосердного',
            style: QadrTheme.display(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: QadrColors.textSoft,
            ),
          ),
          const SizedBox(height: 14),
          // Star divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        QadrColors.line2,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Star8Medallion(
                  size: 10,
                  color: QadrColors.textFaint,
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        QadrColors.line2,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _AyahTile extends StatelessWidget {
  const _AyahTile({
    required this.ayah,
    required this.showTranslation,
    this.isHighlighted = false,
  });
  final Ayah ayah;
  final bool showTranslation;
  final bool isHighlighted;

  String _translation(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return switch (locale) {
      'ar' => '',
      'ru' => ayah.textRussian,
      _ => ayah.textEnglish,
    };
  }

  @override
  Widget build(BuildContext context) {
    final translation = _translation(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Arabic text with star medallion
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Star8Medallion(
                size: 30,
                child: Text(
                  '${ayah.ayahNumber}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  ayah.textArabic,
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    height: 2.1,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          if (showTranslation && translation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              translation,
              style: QadrTheme.display(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: QadrColors.textMuted,
              ).copyWith(height: 1.6),
            ),
          ],
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/data/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/floating_nav_bar.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/scene_background.dart';
import '../../../core/widgets/scene_page.dart';
import 'providers/quran_providers.dart';

class QuranListScreen extends ConsumerStatefulWidget {
  final ValueChanged<NavSection> onNavChanged;

  const QuranListScreen({super.key, required this.onNavChanged});

  @override
  ConsumerState<QuranListScreen> createState() => _QuranListScreenState();
}

class _QuranListScreenState extends ConsumerState<QuranListScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(quranSearchQueryProvider.notifier).state =
          _searchController.text;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(quranSearchQueryProvider.notifier).state = '';
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(surahListProvider);
    final query = ref.watch(quranSearchQueryProvider);
    final language = Localizations.localeOf(context).languageCode;
    final topPadding = MediaQuery.of(context).padding.top;
    final isSearching = query.trim().length >= 2;

    return ScenePage(
      scene: SceneType.dusk,
      topGradientStrength: 0.45,
      children: [
        // Title
        Positioned(
          top: topPadding + 10,
          left: 26,
          right: 26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.quran.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Color(0x99F4EFE6),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                context.l10n.surahs,
                style: QadrTheme.display(
                  fontSize: 34,
                  color: const Color(0xFFF4EFE6),
                ),
              ),
            ],
          ),
        ),

        // Search field
        Positioned(
          top: topPadding + 116,
          left: 22,
          right: 22,
          child: _buildSearchField(context),
        ),

        // Content: surah list or search results
        Positioned(
          top: topPadding + 170,
          left: 22,
          right: 22,
          bottom: 145,
          child: isSearching
              ? ref
                    .watch(quranSearchProvider(language))
                    .when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFF4EFE6),
                        ),
                      ),
                      error: (e, _) => Center(
                        child: Text(
                          context.l10n.errorWithMessage(e.toString()),
                          style: const TextStyle(color: Color(0xFFF4EFE6)),
                        ),
                      ),
                      data: (results) => _SearchResultsCard(
                        results: results,
                        language: language,
                      ),
                    )
              : surahsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFFF4EFE6)),
                  ),
                  error: (e, _) => Center(
                    child: Text(
                      context.l10n.errorWithMessage(e.toString()),
                      style: const TextStyle(color: Color(0xFFF4EFE6)),
                    ),
                  ),
                  data: (surahs) => _SurahListCard(surahs: surahs),
                ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return ClipRRect(
      borderRadius: QadrRadius.pillAll,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0x52140C0C),
            borderRadius: QadrRadius.pillAll,
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 15, color: Color(0xBFF4EFE6)),
              const SizedBox(width: 10),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFF4EFE6),
                    ),
                    cursorColor: const Color(0xBFF4EFE6),
                    decoration: InputDecoration(
                      hintText: context.l10n.searchSurahOrAyah,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xBFF4EFE6),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        key: const ValueKey('clear'),
                        onTap: _clearSearch,
                        child: const Icon(
                          Icons.close,
                          size: 15,
                          color: Color(0xBFF4EFE6),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurahListCard extends StatelessWidget {
  final List<Surah> surahs;
  const _SurahListCard({required this.surahs});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 20,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: QadrSpacing.md,
          vertical: 6,
        ),
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return _SurahRow(
            surah: surah,
            showBorder: index < surahs.length - 1,
            onTap: () => context.push('/quran/${surah.number}'),
          );
        },
      ),
    );
  }
}

class _SearchResultsCard extends StatelessWidget {
  final QuranSearchResults results;
  final String language;

  const _SearchResultsCard({required this.results, required this.language});

  String _ayahText(Ayah ayah) {
    return switch (language) {
      'ar' => ayah.textArabic,
      'ru' => ayah.textRussian,
      _ => ayah.textEnglish,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return GlassContainer(
        borderRadius: 20,
        child: Center(
          child: Text(
            context.l10n.searchNoResults,
            style: const TextStyle(fontSize: 14, color: Color(0x8CF4EFE6)),
          ),
        ),
      );
    }

    final items = <Widget>[];

    if (results.surahs.isNotEmpty) {
      items.add(_SectionHeader(label: context.l10n.surahs));
      for (var i = 0; i < results.surahs.length; i++) {
        final surah = results.surahs[i];
        items.add(
          _SurahRow(
            surah: surah,
            showBorder:
                i < results.surahs.length - 1 || results.ayahs.isNotEmpty,
            onTap: () => context.push('/quran/${surah.number}'),
          ),
        );
      }
    }

    if (results.ayahs.isNotEmpty) {
      items.add(_SectionHeader(label: context.l10n.searchResultsAyahs));
      for (var i = 0; i < results.ayahs.length; i++) {
        final ayah = results.ayahs[i];
        items.add(
          _AyahResultRow(
            ayah: ayah,
            text: _ayahText(ayah),
            showBorder: i < results.ayahs.length - 1,
          ),
        );
      }
    }

    return GlassContainer(
      borderRadius: 20,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: QadrSpacing.md,
          vertical: 6,
        ),
        children: items,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 2,
          color: Color(0x99F4EFE6),
        ),
      ),
    );
  }
}

class _AyahResultRow extends StatelessWidget {
  final Ayah ayah;
  final String text;
  final bool showBorder;

  const _AyahResultRow({
    required this.ayah,
    required this.text,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push('/quran/${ayah.surahNumber}?ayah=${ayah.ayahNumber}'),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
        decoration: showBorder
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0x12FFFFFF))),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '${ayah.surahNumber}:${ayah.ayahNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0x8CF4EFE6)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Color(0xFFF4EFE6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahRow extends StatelessWidget {
  final Surah surah;
  final bool showBorder;
  final VoidCallback onTap;

  const _SurahRow({
    required this.surah,
    required this.showBorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final place = surah.revelationType == 'Meccan'
        ? context.l10n.meccan
        : context.l10n.medinan;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
        decoration: showBorder
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0x12FFFFFF))),
              )
            : null,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                '${surah.number}',
                textAlign: TextAlign.center,
                style: QadrTheme.display(
                  fontSize: 16,
                  color: const Color(0x8CF4EFE6),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameEnglish,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFFF4EFE6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${surah.nameRussian} · ${context.l10n.ayahCount(surah.ayahCount)} · $place',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0x8CF4EFE6),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              surah.nameArabic,
              style: GoogleFonts.amiri(
                fontSize: 20,
                color: const Color(0xFFF4EFE6),
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

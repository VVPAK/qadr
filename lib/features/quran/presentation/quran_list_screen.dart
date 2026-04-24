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

class QuranListScreen extends ConsumerWidget {
  final ValueChanged<NavSection> onNavChanged;

  const QuranListScreen({super.key, required this.onNavChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(surahListProvider);
    final topPadding = MediaQuery.of(context).padding.top;

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

        // Search pill
        Positioned(
          top: topPadding + 116,
          left: 22,
          right: 22,
          child: _buildSearchPill(context),
        ),

        // Sura list
        Positioned(
          top: topPadding + 170,
          left: 22,
          right: 22,
          bottom: 145,
          child: surahsAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFFF4EFE6)),
            ),
            error: (e, _) => Center(
              child: Text('Error: $e',
                  style: const TextStyle(color: Color(0xFFF4EFE6))),
            ),
            data: (surahs) => _SurahListCard(surahs: surahs),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchPill(BuildContext context) {
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
              Text(
                context.l10n.searchSurahOrAyah,
                style: const TextStyle(fontSize: 13, color: Color(0xBFF4EFE6)),
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
        padding: const EdgeInsets.symmetric(horizontal: QadrSpacing.md, vertical: 6),
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
                border: Border(
                  bottom: BorderSide(color: Color(0x12FFFFFF)),
                ),
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

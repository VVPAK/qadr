import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/chat_component.dart';
import '../../../chat/domain/models/component_data.dart';

import '../../../../app/theme.dart';

class QuranAyahCard extends StatelessWidget with ChatComponent {
  const QuranAyahCard({super.key, required this.data});
  final QuranAyahData data;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'quranAyah',
        ...data.toJson(),
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(QadrSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < data.ayahs.length; i++) ...[
              if (i > 0) const SizedBox(height: QadrSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Surah:Ayah reference
                  Text(
                    '${data.ayahs[i].surah}:${data.ayahs[i].ayah}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: QadrSpacing.sm),
                  // Arabic text
                  Text(
                    data.ayahs[i].arabic,
                    style: GoogleFonts.amiri(
                      fontSize: 22,
                      height: 1.8,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: QadrSpacing.sm),
                  // Translation
                  Text(
                    data.ayahs[i].translation,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
            // Open in Quran reader button
            if (data.ayahs.isNotEmpty) ...[
              const SizedBox(height: QadrSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: () {
                    final ayah = data.ayahs.first;
                    context.push('/quran/${ayah.surah}?ayah=${ayah.ayah}');
                  },
                  icon: const Icon(Icons.menu_book_outlined, size: 18),
                  label: Text(context.l10n.openInQuran),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

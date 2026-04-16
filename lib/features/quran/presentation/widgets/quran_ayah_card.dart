import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/models/component_data.dart';

class QuranAyahCard extends StatelessWidget {
  const QuranAyahCard({super.key, required this.data});
  final QuranAyahData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...data.ayahs.map((ayah) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Surah:Ayah reference
                      Text(
                        '${ayah.surah}:${ayah.ayah}',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Arabic text
                      Text(
                        ayah.arabic,
                        style: GoogleFonts.amiri(
                          fontSize: 22,
                          height: 1.8,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 8),
                      // Translation
                      Text(
                        ayah.translation,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

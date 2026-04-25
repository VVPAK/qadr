import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/chat_component.dart';
import '../../domain/models/component_data.dart';

import '../../../../app/theme.dart';

class DuaChatCard extends StatelessWidget with ChatComponent {
  const DuaChatCard({super.key, required this.data});
  final DuaData data;

  @override
  Map<String, dynamic> toContextJson() => {'type': 'dua', ...data.toJson()};

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(QadrSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              data.arabic,
              style: GoogleFonts.amiri(fontSize: 24, height: 1.8),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              data.transliteration,
              style: context.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QadrSpacing.sm),
            Text(
              data.translation,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QadrSpacing.sm),
            Text(
              data.source,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}

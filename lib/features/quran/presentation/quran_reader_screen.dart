import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';

class QuranReaderScreen extends StatelessWidget {
  const QuranReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quran),
      ),
      body: const Center(
        child: Text('Quran Reader — coming soon'),
      ),
    );
  }
}

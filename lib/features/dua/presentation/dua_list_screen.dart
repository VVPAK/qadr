import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';

class DuaListScreen extends StatelessWidget {
  const DuaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dua),
      ),
      body: const Center(
        child: Text('Dua List — coming soon'),
      ),
    );
  }
}

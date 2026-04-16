import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';

class NameInputStep extends ConsumerStatefulWidget {
  const NameInputStep({
    super.key,
    required this.onComplete,
    required this.onBack,
  });
  final VoidCallback onComplete;
  final VoidCallback onBack;

  @override
  ConsumerState<NameInputStep> createState() => _NameInputStepState();
}

class _NameInputStepState extends ConsumerState<NameInputStep> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      final prefs = await ref.read(userPreferencesProvider.future);
      prefs.name = name;
    }
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.onboardingName,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: context.l10n.onboardingNameHint,
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _submit,
            child: Text(context.l10n.onboardingStart),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: widget.onComplete,
            child: Text(context.l10n.skip),
          ),
        ],
      ),
    );
  }
}

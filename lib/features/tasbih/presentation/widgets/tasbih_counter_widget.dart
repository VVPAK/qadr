import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../chat/domain/chat_component.dart';
import '../../../chat/domain/models/component_data.dart';

import '../../../../app/theme.dart';

class TasbihCounterWidget extends StatefulWidget with ChatComponent {
  const TasbihCounterWidget({super.key, required this.data});
  final TasbihData data;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'tasbih',
        ...data.toJson(),
      };

  @override
  State<TasbihCounterWidget> createState() => _TasbihCounterWidgetState();
}

class _TasbihCounterWidgetState extends State<TasbihCounterWidget>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  void _increment() {
    setState(() => _count++);

    // Vibration at milestones
    if (_count == 33 || _count == 66) {
      HapticFeedback.lightImpact();
    } else if (_count == 99) {
      HapticFeedback.mediumImpact();
    } else if (_count == 100 || _count == widget.data.targetCount) {
      HapticFeedback.heavyImpact();
    }
  }

  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(QadrSpacing.md),
        child: Column(
          children: [
            Text(
              widget.data.dhikrText,
              style: GoogleFonts.amiri(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: QadrSpacing.md),
            GestureDetector(
              onTap: _increment,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primaryContainer,
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$_count',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: QadrSpacing.sm),
            Text(
              '/ ${widget.data.targetCount}',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            const SizedBox(height: QadrSpacing.sm),
            TextButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

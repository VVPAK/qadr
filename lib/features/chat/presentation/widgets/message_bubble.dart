import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/models/chat_message.dart';

import '../../../../app/theme.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.child});
  final ChatMessage message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        margin: EdgeInsets.only(
          left: isUser ? 48 : 12,
          right: isUser ? 12 : 48,
          top: QadrSpacing.xs,
          bottom: QadrSpacing.xs,
        ),
        padding: const EdgeInsets.symmetric(horizontal: QadrSpacing.md, vertical: 12),
        decoration: BoxDecoration(
          color: isUser
              ? context.colorScheme.primaryContainer
              : context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(QadrRadius.lg),
            topRight: const Radius.circular(QadrRadius.lg),
            bottomLeft: Radius.circular(isUser ? QadrRadius.lg : QadrRadius.xs),
            bottomRight: Radius.circular(isUser ? QadrRadius.xs : QadrRadius.lg),
          ),
        ),
        child: child,
      ),
    );
  }
}

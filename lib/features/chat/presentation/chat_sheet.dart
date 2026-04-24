import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/extensions/context_extensions.dart';
import '../domain/models/chat_message.dart';
import 'providers/chat_provider.dart';
import 'widgets/chat_message_renderer.dart';
import 'widgets/message_bubble.dart';
import 'widgets/typing_indicator.dart';

/// Chat presented as a bottom sheet — triggered by a swipe-up gesture
/// from the main shell. Takes ~90% of the viewport height.
class ChatSheet extends ConsumerStatefulWidget {
  const ChatSheet({super.key});

  @override
  ConsumerState<ChatSheet> createState() => _ChatSheetState();
}

class _ChatSheetState extends ConsumerState<ChatSheet> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    ref.listen(chatMessagesProvider, (_, _) => _scrollToBottom());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(QadrRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(context),
            _buildHeader(context),
            Expanded(
              child: messages.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: QadrSpacing.sm),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessage(context, messages[index]);
                      },
                    ),
            ),
            if (messages.isNotEmpty) _buildShortcutsBar(context),
            _buildInputBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Container(
        width: 44,
        height: 4,
        decoration: BoxDecoration(
          color: QadrColors.textFaint,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.l10n.appTitle,
              style: QadrTheme.display(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/settings');
            },
          ),
        ],
      ),
    );
  }

  List<({String icon, String label, String message})> _getShortcuts(
      BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return switch (lang) {
      'ru' => [
          (icon: '🕌', label: 'Я новичок', message: 'Привет, я хочу начать практиковать Ислам'),
          (icon: '🤲', label: 'Намаз', message: 'Научи меня как делать намаз, шаг за шагом'),
          (icon: '💧', label: 'Вуду', message: 'Покажи мне как правильно делать омовение'),
          (icon: '📖', label: 'Дуа', message: 'Покажи мне дуа на каждый день'),
        ],
      'ar' => [
          (icon: '🕌', label: 'أنا مبتدئ', message: 'مرحباً، أريد أن أبدأ ممارسة الإسلام'),
          (icon: '🤲', label: 'الصلاة', message: 'علمني كيف أصلي خطوة بخطوة'),
          (icon: '💧', label: 'الوضوء', message: 'أرني كيف أتوضأ'),
          (icon: '📖', label: 'دعاء', message: 'أرني أدعية يومية'),
        ],
      _ => [
          (icon: '🕌', label: 'New to Islam', message: "Hi, I want to start practicing Islam"),
          (icon: '🤲', label: 'Prayer', message: 'Teach me how to pray step by step'),
          (icon: '💧', label: 'Wudu', message: 'Show me how to perform wudu'),
          (icon: '📖', label: 'Dua', message: 'Show me daily duas'),
        ],
    };
  }

  Widget _buildEmptyState(BuildContext context) {
    final shortcuts = _getShortcuts(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(QadrSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_outlined,
              size: 48,
              color: context.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: QadrSpacing.md),
            Text(
              context.l10n.chatGreeting,
              style: QadrTheme.display(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: QadrSpacing.sm),
            Text(
              context.l10n.chatSubtitle,
              style: TextStyle(
                fontSize: 13,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: QadrSpacing.lg),
            Wrap(
              spacing: QadrSpacing.sm,
              runSpacing: QadrSpacing.sm,
              alignment: WrapAlignment.center,
              children: shortcuts
                  .map((s) => ActionChip(
                        avatar: Text(s.icon),
                        label: Text(s.label),
                        onPressed: () => _handleSubmit(s.message),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, ChatMessage message) {
    if (message.role == MessageRole.user) {
      return MessageBubble(message: message, child: Text(message.content));
    }
    if (message.isStreaming && message.content.isEmpty) {
      return MessageBubble(message: message, child: const TypingIndicator());
    }
    if (message.llmResponse != null) {
      return MessageBubble(
        message: message,
        child: ChatMessageRenderer(response: message.llmResponse!),
      );
    }
    return MessageBubble(message: message, child: Text(message.content));
  }

  Widget _buildShortcutsBar(BuildContext context) {
    final shortcuts = _getShortcuts(context);
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: shortcuts.length,
        separatorBuilder: (_, _) => const SizedBox(width: QadrSpacing.sm),
        itemBuilder: (context, index) {
          final s = shortcuts[index];
          return ActionChip(
            avatar: Text(s.icon),
            label: Text(s.label),
            onPressed: () => _handleSubmit(s.message),
          );
        },
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(QadrSpacing.sm),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: context.colorScheme.outline),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: context.l10n.typeMessage,
                  isDense: true,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: _handleSubmit,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: () => _handleSubmit(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();
    ref.read(chatMessagesProvider.notifier).sendMessage(text.trim());
  }
}

/// Shows the chat as a large modal bottom sheet.
Future<void> showChatSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    useSafeArea: true,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.92,
      child: const ChatSheet(),
    ),
  );
}

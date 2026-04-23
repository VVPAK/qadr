import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extensions.dart';
import '../domain/models/chat_message.dart';
import 'providers/chat_provider.dart';
import 'widgets/chat_message_renderer.dart';
import 'widgets/message_bubble.dart';
import 'widgets/typing_indicator.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
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
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Qadr'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _buildMessage(context, message);
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

  List<({String icon, String label, String message})> _getShortcuts(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return switch (lang) {
      'ru' => [
        (icon: '🕌', label: 'Я новичок в Исламе', message: 'Привет, я хочу начать практиковать Ислам'),
        (icon: '🤲', label: 'Научи меня намазу', message: 'Научи меня как делать намаз, шаг за шагом'),
        (icon: '💧', label: 'Как делать омовение?', message: 'Покажи мне как правильно делать омовение (вуду)'),
        (icon: '📖', label: 'Покажи дуа', message: 'Покажи мне дуа на каждый день'),
        (icon: '📿', label: 'Тасбих', message: 'Давай сделаем тасбих'),
        (icon: '🧭', label: 'Где Кибла?', message: 'Покажи направление Киблы'),
      ],
      'ar' => [
        (icon: '🕌', label: 'أنا مبتدئ في الإسلام', message: 'مرحباً، أريد أن أبدأ ممارسة الإسلام'),
        (icon: '🤲', label: 'علمني الصلاة', message: 'علمني كيف أصلي خطوة بخطوة'),
        (icon: '💧', label: 'كيف أتوضأ؟', message: 'أرني كيف أتوضأ بالطريقة الصحيحة'),
        (icon: '📖', label: 'أرني دعاء', message: 'أرني أدعية يومية'),
        (icon: '📿', label: 'تسبيح', message: 'هيا نسبح'),
        (icon: '🧭', label: 'أين القبلة؟', message: 'أرني اتجاه القبلة'),
      ],
      _ => [
        (icon: '🕌', label: "I'm new to Islam", message: "Hi, I want to start practicing Islam"),
        (icon: '🤲', label: 'Teach me to pray', message: 'Teach me how to pray step by step'),
        (icon: '💧', label: 'How to do wudu?', message: 'Show me how to perform wudu (ablution)'),
        (icon: '📖', label: 'Show me a dua', message: 'Show me daily duas'),
        (icon: '📿', label: 'Tasbih', message: "Let's do tasbih"),
        (icon: '🧭', label: 'Where is Qibla?', message: 'Show me the Qibla direction'),
      ],
    };
  }

  Widget _buildEmptyState(BuildContext context) {
    final shortcuts = _getShortcuts(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mosque_outlined,
              size: 64,
              color: context.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Assalamu Alaikum!',
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: shortcuts.map((s) => ActionChip(
                avatar: Text(s.icon),
                label: Text(s.label),
                onPressed: () => _handleSubmit(s.message),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, ChatMessage message) {
    if (message.role == MessageRole.user) {
      return MessageBubble(
        message: message,
        child: Text(message.content),
      );
    }

    // Assistant message
    if (message.isStreaming && message.content.isEmpty) {
      return MessageBubble(
        message: message,
        child: const TypingIndicator(),
      );
    }

    if (message.llmResponse != null) {
      return MessageBubble(
        message: message,
        child: ChatMessageRenderer(response: message.llmResponse!),
      );
    }

    return MessageBubble(
      message: message,
      child: Text(message.content),
    );
  }

  Widget _buildShortcutsBar(BuildContext context) {
    final shortcuts = _getShortcuts(context);

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: shortcuts.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
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
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.mosque_outlined),
              onPressed: () =>
                  ref.read(chatMessagesProvider.notifier).showPrayerTimes(),
              tooltip: context.l10n.prayerTimes,
            ),
            IconButton(
              icon: const Icon(Icons.menu_book_outlined),
              onPressed: () => context.push('/quran'),
              tooltip: context.l10n.quran,
            ),
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

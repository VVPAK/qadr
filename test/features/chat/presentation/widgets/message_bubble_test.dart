import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';
import 'package:qadr/features/chat/presentation/widgets/message_bubble.dart';
import 'package:qadr/l10n/app_localizations.dart';

Widget _wrap(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

ChatMessage _msg(MessageRole role, String content) => ChatMessage(
  id: '1',
  role: role,
  content: content,
  timestamp: DateTime(2026),
);

void main() {
  group('MessageBubble', () {
    testWidgets('renders the child widget', (tester) async {
      await tester.pumpWidget(
        _wrap(
          MessageBubble(
            message: _msg(MessageRole.user, 'hi'),
            child: const Text('hello'),
          ),
        ),
      );
      expect(find.text('hello'), findsOneWidget);
    });

    testWidgets('user bubble aligns to the right', (tester) async {
      await tester.pumpWidget(
        _wrap(
          MessageBubble(
            message: _msg(MessageRole.user, 'hi'),
            child: const Text('msg'),
          ),
        ),
      );
      final align = tester.widget<Align>(find.byType(Align).first);
      expect(align.alignment, Alignment.centerRight);
    });

    testWidgets('assistant bubble aligns to the left', (tester) async {
      await tester.pumpWidget(
        _wrap(
          MessageBubble(
            message: _msg(MessageRole.assistant, 'reply'),
            child: const Text('msg'),
          ),
        ),
      );
      final align = tester.widget<Align>(find.byType(Align).first);
      expect(align.alignment, Alignment.centerLeft);
    });
  });
}

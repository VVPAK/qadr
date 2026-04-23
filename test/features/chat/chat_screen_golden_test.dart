@Tags(['golden'])
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';
import 'package:qadr/features/chat/presentation/providers/chat_provider.dart';
import 'package:qadr/features/chat/presentation/chat_screen.dart';

import '../../helpers/golden_test_helpers.dart';

void main() {
  goldenTest(
    'chat_screen',
    providerOverrides: [
      chatMessagesProvider.overrideWith(
        (ref) => ChatMessagesNotifier(ref)..state = const <ChatMessage>[],
      ),
    ],
    builder: (_) => const ChatScreen(),
  );
}

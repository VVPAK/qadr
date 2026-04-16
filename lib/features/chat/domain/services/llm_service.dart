import '../models/chat_message.dart';

abstract class LlmService {
  Future<String> sendMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  });

  Stream<String> streamMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  });
}

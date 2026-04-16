import '../domain/models/chat_message.dart';

class ChatRepository {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void addMessage(ChatMessage message) {
    _messages.add(message);
  }

  void updateMessage(String id, ChatMessage updated) {
    final index = _messages.indexWhere((m) => m.id == id);
    if (index != -1) {
      _messages[index] = updated;
    }
  }

  void clear() => _messages.clear();
}

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/data/chat_repository.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';

ChatMessage _msg(String id, {String content = 'hi'}) => ChatMessage(
  id: id,
  role: MessageRole.user,
  content: content,
  timestamp: DateTime(2026, 1, 1),
);

void main() {
  test('a new repository exposes an empty message list', () {
    final repo = ChatRepository();
    expect(repo.messages, isEmpty);
  });

  test('addMessage appends in insertion order', () {
    final repo = ChatRepository()
      ..addMessage(_msg('1'))
      ..addMessage(_msg('2'))
      ..addMessage(_msg('3'));
    expect(repo.messages.map((m) => m.id).toList(), ['1', '2', '3']);
  });

  test('messages getter returns an unmodifiable view', () {
    final repo = ChatRepository()..addMessage(_msg('1'));
    expect(() => repo.messages.add(_msg('2')), throwsUnsupportedError);
  });

  test('updateMessage replaces the entry with the matching id', () {
    final repo = ChatRepository()
      ..addMessage(_msg('1', content: 'old'))
      ..addMessage(_msg('2', content: 'keep'));

    repo.updateMessage('1', _msg('1', content: 'new'));

    expect(repo.messages.firstWhere((m) => m.id == '1').content, 'new');
    expect(repo.messages.firstWhere((m) => m.id == '2').content, 'keep');
  });

  test('updateMessage is a no-op when the id is not present', () {
    final repo = ChatRepository()..addMessage(_msg('1', content: 'keep'));
    repo.updateMessage('missing', _msg('missing', content: 'x'));
    expect(repo.messages, hasLength(1));
    expect(repo.messages.single.content, 'keep');
  });

  test('clear empties the list but leaves the repository usable', () {
    final repo = ChatRepository()
      ..addMessage(_msg('1'))
      ..addMessage(_msg('2'));
    repo.clear();
    expect(repo.messages, isEmpty);
    repo.addMessage(_msg('3'));
    expect(repo.messages.single.id, '3');
  });
}

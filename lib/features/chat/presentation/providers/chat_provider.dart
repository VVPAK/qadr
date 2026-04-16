import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/preferences_provider.dart';
import '../../data/chat_repository.dart';
import '../../data/openai_llm_service.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/services/intent_parser.dart';
import '../../domain/services/system_prompt_builder.dart';
import '../../../learning/presentation/providers/learning_provider.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());
final llmServiceProvider = Provider((ref) => OpenAiLlmService());

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier(ref);
});

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier(this._ref) : super([]);

  final Ref _ref;

  Future<void> sendMessage(String text) async {
    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: text,
      timestamp: DateTime.now(),
    );
    state = [...state, userMessage];

    // Add placeholder assistant message
    final assistantId =
        (DateTime.now().millisecondsSinceEpoch + 1).toString();
    final placeholder = ChatMessage(
      id: assistantId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      isStreaming: true,
    );
    state = [...state, placeholder];

    try {
      final prefs = await _ref.read(userPreferencesProvider.future);
      final learningStore = _ref.read(learningProgressProvider);
      final systemPrompt = SystemPromptBuilder.build(
        madhab: prefs.madhab,
        language: prefs.language,
        latitude: prefs.latitude,
        longitude: prefs.longitude,
        userName: prefs.name,
        learningProgress: learningStore.overallProgress,
        currentLessonId: learningStore.currentLessonId,
      );

      final llmService = _ref.read(llmServiceProvider);
      final rawResponse = await llmService.sendMessage(
        messages: state.where((m) => m.role != MessageRole.system).toList(),
        systemPrompt: systemPrompt,
      );

      final parsed = IntentParser.parse(rawResponse);
      final response = parsed ?? IntentParser.fallbackTextResponse(rawResponse);

      final displayText = response.text ?? rawResponse;

      state = [
        ...state.where((m) => m.id != assistantId),
        ChatMessage(
          id: assistantId,
          role: MessageRole.assistant,
          content: displayText,
          timestamp: DateTime.now(),
          llmResponse: response,
          isStreaming: false,
        ),
      ];
    } catch (e) {
      state = [
        ...state.where((m) => m.id != assistantId),
        ChatMessage(
          id: assistantId,
          role: MessageRole.assistant,
          content: e.toString(),
          timestamp: DateTime.now(),
          isStreaming: false,
        ),
      ];
    }
  }
}

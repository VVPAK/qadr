import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/islamic_constants.dart';
import '../../../../core/data/preferences/user_preferences.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../data/chat_repository.dart';
import '../../data/openai_llm_service.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/models/component_data.dart';
import '../../domain/models/llm_response.dart';
import '../../domain/services/intent_parser.dart';
import '../../domain/services/llm_service.dart';
import '../../domain/services/system_prompt_builder.dart';
import '../../../learning/presentation/providers/learning_provider.dart';
import '../../../prayer/presentation/providers/prayer_times_provider.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());
final llmServiceProvider = Provider<LlmService>((ref) => OpenAiLlmService());

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
      final finalResponse = _maybeOverridePrayerTimes(response, prefs);

      final displayText = finalResponse.text ?? rawResponse;

      state = [
        ...state.where((m) => m.id != assistantId),
        ChatMessage(
          id: assistantId,
          role: MessageRole.assistant,
          content: displayText,
          timestamp: DateTime.now(),
          llmResponse: finalResponse,
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

  Future<void> discussAyah({
    required int surahNumber,
    required int ayahNumber,
    required String textArabic,
    required String translation,
    required String surahName,
  }) async {
    final ayahRef = '$surahNumber:$ayahNumber';

    // Show ayah card in chat
    final componentId = DateTime.now().millisecondsSinceEpoch.toString();
    final componentMessage = ChatMessage(
      id: componentId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      llmResponse: LlmResponse(
        intent: ChatIntent.quranSearch,
        responseType: ResponseType.component,
        component: ComponentPayload(
          type: 'quranAyah',
          data: {
            'ayahs': [
              {
                'surah': surahNumber,
                'ayah': ayahNumber,
                'arabic': textArabic,
                'translation': translation,
              }
            ],
          },
        ),
      ),
      isStreaming: false,
    );
    state = [...state, componentMessage];

    // Ask LLM to explain
    final prefs = await _ref.read(userPreferencesProvider.future);
    final lang = prefs.language;
    final question = switch (lang) {
      'ru' => 'Расскажи об аяте $ayahRef ($surahName)',
      'ar' => 'أخبرني عن الآية $ayahRef ($surahName)',
      _ => 'Tell me about ayah $ayahRef ($surahName)',
    };
    await sendMessage(question);
  }

  Future<void> showPrayerTimes() async {
    final prefs = await _ref.read(userPreferencesProvider.future);
    final lat = prefs.latitude;
    final lng = prefs.longitude;

    if (lat == null || lng == null) {
      sendMessage('Prayer Times');
      return;
    }

    final service = _ref.read(prayerTimesServiceProvider);
    final model = service.calculate(latitude: lat, longitude: lng);
    final componentData = service.toComponentData(model);

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: 'Prayer Times',
      timestamp: DateTime.now(),
    );

    final assistantId =
        (DateTime.now().millisecondsSinceEpoch + 1).toString();
    final assistantMessage = ChatMessage(
      id: assistantId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      llmResponse: LlmResponse(
        intent: ChatIntent.prayerTime,
        responseType: ResponseType.component,
        component: ComponentPayload(
          type: 'prayerTimes',
          data: _prayerTimesDataToMap(componentData),
        ),
      ),
      isStreaming: false,
    );

    state = [...state, userMessage, assistantMessage];
  }

  LlmResponse _maybeOverridePrayerTimes(
    LlmResponse response,
    UserPreferences prefs,
  ) {
    if (response.intent != ChatIntent.prayerTime) return response;

    final lat = prefs.latitude;
    final lng = prefs.longitude;
    if (lat == null || lng == null) return response;

    final service = _ref.read(prayerTimesServiceProvider);
    final model = service.calculate(latitude: lat, longitude: lng);
    final componentData = service.toComponentData(model);

    return LlmResponse(
      intent: response.intent,
      responseType: ResponseType.component,
      text: response.text,
      component: ComponentPayload(
        type: 'prayerTimes',
        data: _prayerTimesDataToMap(componentData),
      ),
    );
  }

  static Map<String, dynamic> _prayerTimesDataToMap(PrayerTimesData data) =>
      data.toJson()..remove('runtimeType');
}

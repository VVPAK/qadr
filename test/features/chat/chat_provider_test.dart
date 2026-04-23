import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/providers/preferences_provider.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';
import 'package:qadr/features/chat/domain/services/llm_service.dart';
import 'package:qadr/features/chat/presentation/providers/chat_provider.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeLlmService implements LlmService {
  _FakeLlmService({this.response = '', this.error});

  String response;
  Object? error;
  List<ChatMessage>? lastMessages;
  String? lastSystemPrompt;
  Completer<String>? pending;

  @override
  Future<String> sendMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) async {
    lastMessages = messages;
    lastSystemPrompt = systemPrompt;
    if (error != null) throw error!;
    if (pending != null) return pending!.future;
    return response;
  }

  @override
  Stream<String> streamMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) {
    throw UnimplementedError();
  }
}

Future<ProviderContainer> _makeContainer({
  required _FakeLlmService llm,
  Map<String, Object> prefs = const {
    'madhab': 0,
    'language': 'en',
  },
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final sharedPrefs = await SharedPreferences.getInstance();
  final userPrefs = UserPreferences(sharedPrefs);
  final learningStore = LearningProgressStore(sharedPrefs);

  return ProviderContainer(overrides: [
    userPreferencesProvider.overrideWith((_) async => userPrefs),
    learningProgressProvider.overrideWithValue(learningStore),
    llmServiceProvider.overrideWithValue(llm),
  ]);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChatMessagesNotifier.sendMessage', () {
    test('adds user + placeholder synchronously, then replaces placeholder '
        'with parsed LLM response', () async {
      final llm = _FakeLlmService(response: '');
      llm.pending = Completer<String>();
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      final notifier = container.read(chatMessagesProvider.notifier);
      final future = notifier.sendMessage('what time is dhuhr?');

      // Pump until the LLM call is reached (it never resolves — pending).
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final intermediate = container.read(chatMessagesProvider);
      expect(intermediate, hasLength(2));
      expect(intermediate[0].role, MessageRole.user);
      expect(intermediate[0].content, 'what time is dhuhr?');
      expect(intermediate[1].role, MessageRole.assistant);
      expect(intermediate[1].isStreaming, isTrue);
      expect(intermediate[1].content, '');

      llm.pending!.complete(
        '{"intent":"generalQuestion","responseType":"text","text":"Salam"}',
      );
      await future;

      final finalState = container.read(chatMessagesProvider);
      expect(finalState, hasLength(2));
      expect(finalState.last.role, MessageRole.assistant);
      expect(finalState.last.isStreaming, isFalse);
      expect(finalState.last.content, 'Salam');
      expect(finalState.last.llmResponse, isNotNull);
      expect(finalState.last.llmResponse!.intent, ChatIntent.generalQuestion);
    });

    test('falls back to raw text when the LLM output is not JSON', () async {
      final llm = _FakeLlmService(response: 'just a sentence.');
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('hi');

      final state = container.read(chatMessagesProvider);
      expect(state.last.content, 'just a sentence.');
      expect(state.last.llmResponse, isNotNull);
      expect(state.last.llmResponse!.intent, ChatIntent.generalQuestion);
      expect(state.last.llmResponse!.responseType, ResponseType.text);
    });

    test('records the error on the assistant message when the LLM throws',
        () async {
      final llm = _FakeLlmService()..error = Exception('no api key');
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('hi');

      final state = container.read(chatMessagesProvider);
      expect(state, hasLength(2));
      expect(state.last.role, MessageRole.assistant);
      expect(state.last.isStreaming, isFalse);
      expect(state.last.content, contains('no api key'));
    });

    test('forwards the configured madhab and language through the system '
        'prompt and chat history to the LLM', () async {
      final llm = _FakeLlmService(
        response: '{"intent":"generalQuestion","responseType":"text"}',
      );
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': Madhab.hanbali.index,
        'language': 'ar',
      });
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('as-salamu alaykum');

      expect(llm.lastSystemPrompt, contains('Hanbali'));
      expect(llm.lastSystemPrompt, contains('Arabic'));
      // The history sent to the LLM should include the user message and the
      // still-streaming placeholder — both non-system.
      expect(llm.lastMessages, hasLength(2));
      expect(llm.lastMessages!.first.content, 'as-salamu alaykum');
      expect(
        llm.lastMessages!.every((m) => m.role != MessageRole.system),
        isTrue,
      );
    });

    test('overrides prayerTime component with locally calculated times when '
        'lat/lng are known', () async {
      final llm = _FakeLlmService(
        response: '{"intent":"prayerTime","responseType":"component",'
            '"component":{"type":"prayerTimes","data":{'
            '"prayers":[{"name":"fajr","time":"99:99","isNext":false}],'
            '"date":"wrong"}}}',
      );
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': 0,
        'language': 'en',
        'latitude': 21.4225,
        'longitude': 39.8262,
      });
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('prayer times?');

      final component =
          container.read(chatMessagesProvider).last.llmResponse!.component!;
      expect(component.type, 'prayerTimes');
      final prayers = component.data['prayers'] as List;
      // Locally computed times — 6 canonical prayers in order.
      expect(prayers.map((p) => p['name']).toList(),
          ['fajr', 'sunrise', 'dhuhr', 'asr', 'maghrib', 'isha']);
      expect(component.data['date'], isNot('wrong'));
      // Date is formatted as YYYY-MM-DD.
      expect(component.data['date'],
          matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
    });

    test('leaves prayerTime response untouched when lat/lng are missing',
        () async {
      final llm = _FakeLlmService(
        response: '{"intent":"prayerTime","responseType":"component",'
            '"component":{"type":"prayerTimes","data":{'
            '"prayers":[{"name":"fajr","time":"05:03","isNext":true}],'
            '"date":"2026-04-23"}}}',
      );
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('prayer times?');

      final component =
          container.read(chatMessagesProvider).last.llmResponse!.component!;
      expect(component.data['date'], '2026-04-23');
      expect((component.data['prayers'] as List).length, 1);
    });

    test('does not override non-prayerTime intents even when lat/lng are set',
        () async {
      final llm = _FakeLlmService(
        response: '{"intent":"qibla","responseType":"component",'
            '"component":{"type":"qibla","data":{}}}',
      );
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': 0,
        'language': 'en',
        'latitude': 21.4225,
        'longitude': 39.8262,
      });
      addTearDown(container.dispose);

      await container
          .read(chatMessagesProvider.notifier)
          .sendMessage('where is qibla?');

      final component =
          container.read(chatMessagesProvider).last.llmResponse!.component!;
      expect(component.type, 'qibla');
    });
  });

  group('ChatMessagesNotifier.showPrayerTimes', () {
    test('appends user+assistant messages with a prayerTimes component '
        'without calling the LLM when location is known', () async {
      final llm = _FakeLlmService();
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': 0,
        'language': 'en',
        'latitude': 21.4225,
        'longitude': 39.8262,
      });
      addTearDown(container.dispose);

      await container.read(chatMessagesProvider.notifier).showPrayerTimes();

      expect(llm.lastMessages, isNull); // LLM was not called
      final state = container.read(chatMessagesProvider);
      expect(state, hasLength(2));
      expect(state.first.role, MessageRole.user);
      expect(state.first.content, 'Prayer Times');
      expect(state.last.llmResponse!.component!.type, 'prayerTimes');
      expect(state.last.llmResponse!.intent, ChatIntent.prayerTime);
    });

    test('falls back to the LLM flow when location is unknown', () async {
      final llm = _FakeLlmService(
        response: '{"intent":"prayerTime","responseType":"text","text":"?"}',
      );
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      await container.read(chatMessagesProvider.notifier).showPrayerTimes();

      expect(llm.lastMessages, isNotNull);
      expect(llm.lastMessages!.first.content, 'Prayer Times');
    });
  });

  group('ChatMessagesNotifier.discussAyah', () {
    test('inserts a quranAyah card, then asks the LLM in the user language',
        () async {
      final llm = _FakeLlmService(
        response: '{"intent":"quranSearch","responseType":"text","text":"ok"}',
      );
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': 0,
        'language': 'ru',
      });
      addTearDown(container.dispose);

      await container.read(chatMessagesProvider.notifier).discussAyah(
            surahNumber: 1,
            ayahNumber: 1,
            textArabic: 'بسم الله',
            translation: 'In the name of Allah',
            surahName: 'Al-Fatihah',
          );

      final state = container.read(chatMessagesProvider);
      // First message: ayah card
      expect(state.first.role, MessageRole.assistant);
      expect(state.first.llmResponse!.component!.type, 'quranAyah');
      final ayah =
          (state.first.llmResponse!.component!.data['ayahs'] as List).first
              as Map;
      expect(ayah['surah'], 1);
      expect(ayah['ayah'], 1);

      // Then: user question in Russian
      final userMessages =
          state.where((m) => m.role == MessageRole.user).toList();
      expect(userMessages, hasLength(1));
      expect(userMessages.single.content, contains('1:1'));
      expect(userMessages.single.content, contains('Al-Fatihah'));
      expect(userMessages.single.content, contains('аяте'));
    });

    test('picks Arabic question template for ar locale', () async {
      final llm = _FakeLlmService(
        response: '{"intent":"quranSearch","responseType":"text"}',
      );
      final container = await _makeContainer(llm: llm, prefs: {
        'madhab': 0,
        'language': 'ar',
      });
      addTearDown(container.dispose);

      await container.read(chatMessagesProvider.notifier).discussAyah(
            surahNumber: 2,
            ayahNumber: 255,
            textArabic: 'الله',
            translation: 'Allah',
            surahName: 'Al-Baqarah',
          );

      final userMsg = container
          .read(chatMessagesProvider)
          .firstWhere((m) => m.role == MessageRole.user);
      expect(userMsg.content, contains('الآية'));
      expect(userMsg.content, contains('2:255'));
    });

    test('defaults to English question for en locale', () async {
      final llm = _FakeLlmService(
        response: '{"intent":"quranSearch","responseType":"text"}',
      );
      final container = await _makeContainer(llm: llm);
      addTearDown(container.dispose);

      await container.read(chatMessagesProvider.notifier).discussAyah(
            surahNumber: 2,
            ayahNumber: 255,
            textArabic: 'الله',
            translation: 'Allah',
            surahName: 'Al-Baqarah',
          );

      final userMsg = container
          .read(chatMessagesProvider)
          .firstWhere((m) => m.role == MessageRole.user);
      expect(userMsg.content, 'Tell me about ayah 2:255 (Al-Baqarah)');
    });
  });
}

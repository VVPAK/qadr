import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';
import 'package:qadr/features/chat/presentation/widgets/chat_message_renderer.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _wrap(Widget child) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final store = LearningProgressStore(prefs);

  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, _) => Scaffold(body: SingleChildScrollView(child: child))),
    GoRoute(path: '/quran/:surahNumber', builder: (_, _) => const Scaffold()),
  ]);

  return ProviderScope(
    overrides: [learningProgressProvider.overrideWithValue(store)],
    child: MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

LlmResponse _textResponse(String text) => LlmResponse(
  intent: ChatIntent.generalQuestion,
  responseType: ResponseType.text,
  text: text,
);

LlmResponse _componentResponse(
  String type,
  Map<String, dynamic> data, {
  String? text,
}) => LlmResponse(
  intent: ChatIntent.generalQuestion,
  responseType: ResponseType.component,
  text: text,
  component: ComponentPayload(type: type, data: data),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChatMessageRenderer - text responses', () {
    testWidgets('renders for text responseType without throwing', (tester) async {
      await tester.pumpWidget(await _wrap(
        ChatMessageRenderer(response: _textResponse('Hello world')),
      ));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('null component falls through to text rendering', (tester) async {
      final response = LlmResponse(
        intent: ChatIntent.generalQuestion,
        responseType: ResponseType.component,
        text: 'fallback',
        component: null,
      );
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('ChatMessageRenderer - component rendering', () {
    testWidgets('renders prayerTimes component', (tester) async {
      final response = _componentResponse('prayerTimes', {
        'prayers': [
          {'name': 'fajr', 'time': '05:03', 'isNext': true},
        ],
        'date': '2026-04-24',
      });
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(find.text('05:03'), findsWidgets);
    });

    testWidgets('renders dua component', (tester) async {
      final response = _componentResponse('dua', {
        'arabic': 'ربي',
        'transliteration': 'Rabbi',
        'translation': 'My Lord',
        'source': 'Quran',
      });
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(find.text('ربي'), findsOneWidget);
    });

    testWidgets('renders tasbih component', (tester) async {
      final response = _componentResponse('tasbih', {
        'dhikrText': 'SubhanAllah',
        'targetCount': 33,
      });
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders learningStart component with first lesson', (tester) async {
      final response = _componentResponse('learningStart', {});
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders learningProgress component', (tester) async {
      final response = _componentResponse('learningProgress', {});
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders known lessonCard component', (tester) async {
      final response = _componentResponse('lessonCard', {'lessonId': 'shahada'});
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders lessonCard with null lessonId as invalid', (tester) async {
      final response = _componentResponse('lessonCard', {});
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('unknown component type falls back to markdown', (tester) async {
      final response = _componentResponse('unknownType', {}, text: 'fallback');
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders text + component when text is non-empty', (tester) async {
      final response = _componentResponse(
        'dua',
        {'arabic': 'ربي', 'transliteration': 'r', 'translation': 't', 'source': 's'},
        text: 'Here is a dua.',
      );
      await tester.pumpWidget(await _wrap(ChatMessageRenderer(response: response)));
      await tester.pump();
      expect(find.text('ربي'), findsOneWidget);
    });
  });
}

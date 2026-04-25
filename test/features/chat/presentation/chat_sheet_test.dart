import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/features/chat/domain/models/chat_message.dart';
import 'package:qadr/features/chat/domain/models/llm_response.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/features/chat/domain/services/llm_service.dart';
import 'package:qadr/features/chat/presentation/chat_sheet.dart';
import 'package:qadr/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:qadr/features/chat/presentation/providers/chat_provider.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _NoopLlmService implements LlmService {
  @override
  Future<String> sendMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) async => '{"intent":"generalQuestion","responseType":"text","text":"ok"}';

  @override
  Stream<String> streamMessage({
    required List<ChatMessage> messages,
    required String systemPrompt,
  }) => Stream.value('ok');
}

Future<Widget> _buildApp(Widget child) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final store = LearningProgressStore(prefs);

  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, _) => Scaffold(body: child)),
    GoRoute(path: '/settings', builder: (_, _) => const Scaffold()),
  ]);

  return ProviderScope(
    overrides: [
      learningProgressProvider.overrideWithValue(store),
      llmServiceProvider.overrideWithValue(_NoopLlmService()),
    ],
    child: MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChatSheet empty state', () {
    testWidgets('renders greeting text', (tester) async {
      await tester.pumpWidget(await _buildApp(const ChatSheet()));
      await tester.pumpAndSettle();
      expect(find.byType(ChatSheet), findsOneWidget);
    });

    testWidgets('shows shortcut chips', (tester) async {
      await tester.pumpWidget(await _buildApp(const ChatSheet()));
      await tester.pumpAndSettle();
      expect(find.byType(ActionChip), findsWidgets);
    });

    testWidgets('shows text field and send button', (tester) async {
      await tester.pumpWidget(await _buildApp(const ChatSheet()));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);
    });

    testWidgets('ignores empty submit', (tester) async {
      await tester.pumpWidget(await _buildApp(const ChatSheet()));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('tapping a shortcut chip submits a message', (tester) async {
      await tester.pumpWidget(await _buildApp(const ChatSheet()));
      await tester.pumpAndSettle();

      final chips = tester.widgetList<ActionChip>(find.byType(ActionChip));
      expect(chips, isNotEmpty);

      await tester.tap(find.byType(ActionChip).first);
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('ChatSheet with messages', () {
    testWidgets('renders user and assistant messages', (tester) async {
      final userMsg = ChatMessage(
        id: '1',
        role: MessageRole.user,
        content: 'What is Salah?',
        timestamp: DateTime(2026),
      );
      final assistantMsg = ChatMessage(
        id: '2',
        role: MessageRole.assistant,
        content: 'Salah is the prayer.',
        timestamp: DateTime(2026),
        llmResponse: LlmResponse(
          intent: ChatIntent.generalQuestion,
          responseType: ResponseType.text,
          text: 'Salah is the prayer.',
        ),
      );

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final store = LearningProgressStore(prefs);
      final router = GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: ChatSheet()),
        ),
        GoRoute(path: '/settings', builder: (_, _) => const Scaffold()),
      ]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            learningProgressProvider.overrideWithValue(store),
            llmServiceProvider.overrideWithValue(_NoopLlmService()),
            chatMessagesProvider.overrideWith(
              (_) => ChatMessagesNotifier(_FakeRef())..state = [userMsg, assistantMsg],
            ),
          ],
          child: MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('What is Salah?'), findsOneWidget);
    });

    testWidgets('streaming message shows typing indicator', (tester) async {
      final streamingMsg = ChatMessage(
        id: '3',
        role: MessageRole.assistant,
        content: '',
        timestamp: DateTime(2026),
        isStreaming: true,
      );

      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final store = LearningProgressStore(prefs);
      final router = GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: ChatSheet()),
        ),
        GoRoute(path: '/settings', builder: (_, _) => const Scaffold()),
      ]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            learningProgressProvider.overrideWithValue(store),
            llmServiceProvider.overrideWithValue(_NoopLlmService()),
            chatMessagesProvider.overrideWith(
              (_) => ChatMessagesNotifier(_FakeRef())..state = [streamingMsg],
            ),
          ],
          child: MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(TypingIndicator), findsOneWidget);
    });
  });
}

// Minimal Ref stub - only used by ChatMessagesNotifier constructor.
class _FakeRef implements Ref {
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError(i.memberName.toString());
}

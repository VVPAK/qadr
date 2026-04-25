import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:qadr/features/learning/presentation/widgets/learning_progress_card.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _wrap(Widget child, {SharedPreferences? prefs}) async {
  final p = prefs ?? await SharedPreferences.getInstance();
  final store = LearningProgressStore(p);

  return ProviderScope(
    overrides: [learningProgressProvider.overrideWithValue(store)],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LearningProgressCard', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    testWidgets('renders progress bar', (tester) async {
      await tester.pumpWidget(await _wrap(const LearningProgressCard()));
      await tester.pump();
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows "0% complete" on a fresh store', (tester) async {
      await tester.pumpWidget(await _wrap(const LearningProgressCard()));
      await tester.pump();
      expect(find.textContaining('0%'), findsOneWidget);
    });

    testWidgets('shows module list from curriculum', (tester) async {
      await tester.pumpWidget(await _wrap(const LearningProgressCard()));
      await tester.pump();
      for (final module in learningCurriculum) {
        expect(find.textContaining(module.title), findsOneWidget);
      }
    });

    testWidgets('shows Continue button when lessons remain', (tester) async {
      await tester.pumpWidget(await _wrap(const LearningProgressCard()));
      await tester.pump();
      // "Continue:" text appears on the FilledButton label
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('shows all-complete text when all lessons are done', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final store = LearningProgressStore(prefs);
      for (final module in learningCurriculum) {
        for (final lesson in module.lessons) {
          store.completeStep(lesson.id, lesson.steps.length - 1);
        }
      }
      await tester.pumpWidget(await _wrap(const LearningProgressCard(), prefs: prefs));
      await tester.pump();
      // FilledButton should be gone; all-complete text visible
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('toContextJson returns correct type', (tester) async {
      const card = LearningProgressCard();
      expect(card.toContextJson(), {'type': 'learningProgress'});
    });

    testWidgets('onContinue callback is called when button tapped', (tester) async {
      Lesson? received;
      await tester.pumpWidget(await _wrap(
        LearningProgressCard(onContinue: (l) => received = l),
      ));
      await tester.pump();

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(received, isNotNull);
    });
  });
}

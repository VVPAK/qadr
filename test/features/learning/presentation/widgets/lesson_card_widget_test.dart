import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:qadr/features/learning/presentation/widgets/lesson_card_widget.dart';
import 'package:qadr/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _wrap(Widget child) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final store = LearningProgressStore(prefs);

  return ProviderScope(
    overrides: [learningProgressProvider.overrideWithValue(store)],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

final _lesson = learningCurriculum.first.lessons.first; // shahada

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LessonCardWidget', () {
    testWidgets('renders the lesson title', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.text(_lesson.title), findsOneWidget);
    });

    testWidgets('shows step counter as "1 / N"', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.text('1 / ${_lesson.steps.length}'), findsOneWidget);
    });

    testWidgets('renders the first step title', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.text(_lesson.steps.first.title), findsOneWidget);
    });

    testWidgets('shows Next button (FilledButton) on first step', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('does not show Back button on first step', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    });

    testWidgets('toContextJson returns correct lessonId and stepsCount', (tester) async {
      final card = LessonCardWidget(lesson: _lesson);
      final json = card.toContextJson();
      expect(json['lessonId'], _lesson.id);
      expect(json['stepsCount'], _lesson.steps.length);
      expect(json['type'], 'lessonCard');
    });

    testWidgets('starts at specified step', (tester) async {
      await tester.pumpWidget(await _wrap(
        LessonCardWidget(lesson: _lesson, startAtStep: 1),
      ));
      await tester.pump();
      expect(find.text('2 / ${_lesson.steps.length}'), findsOneWidget);
    });

    testWidgets('shows lesson icon in header', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();
      expect(find.text(_lesson.icon), findsOneWidget);
    });

    testWidgets('renders tip section when step has a tip', (tester) async {
      // shahada step at index 2 has a tip
      final stepWithTip = _lesson.steps[2];
      expect(stepWithTip.tip, isNotNull);

      await tester.pumpWidget(await _wrap(
        LessonCardWidget(lesson: _lesson, startAtStep: 2),
      ));
      await tester.pump();
      expect(find.text(stepWithTip.tip!), findsOneWidget);
    });

    testWidgets('tapping Next advances to next step', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();

      expect(find.text('1 / ${_lesson.steps.length}'), findsOneWidget);

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('2 / ${_lesson.steps.length}'), findsOneWidget);
    });

    testWidgets('shows Back button (arrow_back icon) after advancing to step 2', (tester) async {
      await tester.pumpWidget(await _wrap(LessonCardWidget(lesson: _lesson)));
      await tester.pump();

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}

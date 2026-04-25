import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/domain/learning_curriculum.dart';
import 'package:qadr/features/learning/presentation/learn_list_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LearnListScreen', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(_wrap(
        LearnListScreen(onNavChanged: (_) {}),
      ));
      await tester.pump();
      expect(find.byType(LearnListScreen), findsOneWidget);
    });

    testWidgets('shows lesson titles from curriculum', (tester) async {
      await tester.pumpWidget(_wrap(
        LearnListScreen(onNavChanged: (_) {}),
      ));
      await tester.pump();

      final firstLesson = learningCurriculum.first.lessons.first;
      expect(find.textContaining(firstLesson.titleRu), findsWidgets);
    });

    testWidgets('onNavChanged is not called on render', (tester) async {
      var called = false;
      await tester.pumpWidget(_wrap(
        LearnListScreen(onNavChanged: (_) => called = true),
      ));
      await tester.pump();
      expect(called, isFalse);
    });
  });
}

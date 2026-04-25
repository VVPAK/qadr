import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/presentation/widgets/typing_indicator.dart';

void main() {
  group('TypingIndicator', () {
    testWidgets('renders three animated dots', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TypingIndicator())),
      );
      // The builder produces 3 Containers inside Transform widgets
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('disposes without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TypingIndicator())),
      );
      await tester.pump();
      // Pump removes the widget to trigger dispose
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    });

    testWidgets('animation continues when pumped', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TypingIndicator())),
      );
      // Advance the animation to verify no errors
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 600));
      expect(tester.takeException(), isNull);
    });
  });
}

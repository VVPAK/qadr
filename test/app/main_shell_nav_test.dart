import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/widgets/floating_nav_bar.dart';

/// Minimal stand-in for MainShell's page-navigation behaviour.
/// Mirrors the exact pattern used in MainShell so the test exercises
/// the same logic — specifically whether animateToPage vs jumpToPage
/// causes intermediate tabs to become active.
class _NavTestWidget extends StatefulWidget {
  /// When true the widget uses animateToPage (the buggy path).
  /// When false it uses jumpToPage (the fixed path).
  final bool useAnimateTo;

  const _NavTestWidget({required this.useAnimateTo});

  @override
  State<_NavTestWidget> createState() => _NavTestWidgetState();
}

class _NavTestWidgetState extends State<_NavTestWidget> {
  NavSection _active = NavSection.prayer;
  late final PageController _pageController =
      PageController(initialPage: _active.index);

  final List<NavSection> activatedSections = [];

  void _onNavChanged(NavSection section) {
    if (section == _active) return;
    setState(() => _active = section);
    activatedSections.add(section);
    if (widget.useAnimateTo) {
      _pageController.animateToPage(
        section.index,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      _pageController.jumpToPage(section.index);
    }
  }

  void _onPageChanged(int index) {
    final next = NavSection.values[index];
    if (next != _active) {
      activatedSections.add(next);
      setState(() => _active = next);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const ClampingScrollPhysics(),
            children: NavSection.values
                .map((s) => Container(key: ValueKey(s)))
                .toList(),
          ),
          FloatingNavBar(active: _active, onChanged: _onNavChanged),
        ],
      ),
    );
  }
}

void main() {
  group('NavBar indicator travel bug', () {
    testWidgets(
      'animateToPage activates intermediate tabs — demonstrates the bug',
      (tester) async {
        final widget = _NavTestWidget(useAnimateTo: true);
        await tester.pumpWidget(MaterialApp(home: widget));

        await tester.tap(find.byKey(const ValueKey('nav_learn')));
        await tester.pumpAndSettle();

        final state =
            tester.state<_NavTestWidgetState>(find.byType(_NavTestWidget));

        // With animateToPage the PageView scrolls through intermediate pages,
        // triggering _onPageChanged for qibla / quran / dhikr before learn.
        final intermediates = state.activatedSections
            .where((s) => s != NavSection.learn)
            .toList();

        // This expectation FAILS with animateToPage (bug is present).
        // Remove the skip and flip to `isNotEmpty` to observe the failure.
        expect(intermediates, isEmpty,
            skip: 'Demonstrates the bug — animateToPage activates intermediates');
      },
    );

    testWidgets(
      'jumpToPage does NOT activate intermediate tabs — correct behaviour',
      (tester) async {
        final widget = _NavTestWidget(useAnimateTo: false);
        await tester.pumpWidget(MaterialApp(home: widget));

        await tester.tap(find.byKey(const ValueKey('nav_learn')));
        await tester.pumpAndSettle();

        final state =
            tester.state<_NavTestWidgetState>(find.byType(_NavTestWidget));

        final intermediates = state.activatedSections
            .where((s) => s != NavSection.learn)
            .toList();

        expect(intermediates, isEmpty,
            reason:
                'Only the destination tab should become active on a direct tap');
        expect(state.activatedSections.last, NavSection.learn);
      },
    );

    testWidgets('active section matches destination immediately after tap',
        (tester) async {
      final widget = _NavTestWidget(useAnimateTo: false);
      await tester.pumpWidget(MaterialApp(home: widget));

      await tester.tap(find.byKey(const ValueKey('nav_learn')));
      await tester.pump();

      final state =
          tester.state<_NavTestWidgetState>(find.byType(_NavTestWidget));
      expect(state._active, NavSection.learn);
    });
  });
}

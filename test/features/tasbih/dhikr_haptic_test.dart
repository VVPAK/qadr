import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/services/haptic_service.dart';
import 'package:qadr/features/chat/domain/models/component_data.dart';
import 'package:qadr/features/tasbih/presentation/widgets/tasbih_counter_widget.dart';
import 'package:qadr/features/tasbih/presentation/dhikr_screen.dart';

class _FakeHapticService extends HapticService {
  final calls = <String>[];

  @override
  Future<void> lightImpact() async => calls.add('light');

  @override
  Future<void> success() async => calls.add('success');
}

Widget _wrap(Widget child, HapticService haptic) {
  return ProviderScope(
    overrides: [hapticServiceProvider.overrideWithValue(haptic)],
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('DhikrScreen haptics', () {
    testWidgets('every tap triggers lightImpact', (tester) async {
      final fake = _FakeHapticService();
      await tester.pumpWidget(_wrap(
        DhikrScreen(onNavChanged: (_) {}),
        fake,
      ));
      await tester.pump();

      await tester.tap(find.text('0'));
      await tester.pump();

      expect(fake.calls, equals(['light']));
    });

    testWidgets('reaching target triggers success instead of lightImpact',
        (tester) async {
      final fake = _FakeHapticService();
      await tester.pumpWidget(_wrap(
        DhikrScreen(onNavChanged: (_) {}),
        fake,
      ));
      await tester.pump();

      // Default formula is СубханАллах with target=33. Tap 33 times.
      for (var i = 0; i < 33; i++) {
        await tester.tap(find.text('$i'));
        await tester.pump();
      }

      expect(fake.calls.where((c) => c == 'light'), hasLength(32));
      expect(fake.calls.last, 'success');
    });
  });

  group('TasbihCounterWidget haptics', () {
    testWidgets('every tap triggers lightImpact', (tester) async {
      final fake = _FakeHapticService();
      await tester.pumpWidget(_wrap(
        const TasbihCounterWidget(
          data: TasbihData(dhikrText: 'Test', targetCount: 5),
        ),
        fake,
      ));
      await tester.pump();

      await tester.tap(find.text('0'));
      await tester.pump();

      expect(fake.calls, equals(['light']));
    });

    testWidgets('reaching target triggers success instead of lightImpact',
        (tester) async {
      final fake = _FakeHapticService();
      await tester.pumpWidget(_wrap(
        const TasbihCounterWidget(
          data: TasbihData(dhikrText: 'Test', targetCount: 3),
        ),
        fake,
      ));
      await tester.pump();

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('$i'));
        await tester.pump();
      }

      expect(fake.calls.where((c) => c == 'light'), hasLength(2));
      expect(fake.calls.last, 'success');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/learning/data/learning_progress_store.dart';
import 'package:qadr/features/learning/presentation/providers/learning_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LearningStateNotifier> _build() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return LearningStateNotifier(LearningProgressStore(prefs));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('starts with state 0', () async {
    final notifier = await _build();
    expect(notifier.state, 0);
  });

  test('completeStep persists to the store and increments state', () async {
    final notifier = await _build();
    notifier.completeStep('shahada', 0);
    expect(notifier.store.getCompletedStep('shahada'), 0);
    expect(notifier.state, 1);
  });

  test('state increments on every call to trigger listener rebuilds',
      () async {
    final notifier = await _build();
    notifier.completeStep('shahada', 0);
    notifier.completeStep('shahada', 1);
    notifier.completeStep('shahada', 2);
    expect(notifier.state, 3);
    expect(notifier.store.getCompletedStep('shahada'), 2);
  });

  test('startLearning sets hasStarted on the store and bumps state',
      () async {
    final notifier = await _build();
    expect(notifier.store.hasStarted, isFalse);
    notifier.startLearning();
    expect(notifier.store.hasStarted, isTrue);
    expect(notifier.state, 1);
  });

  test('state bumps even when completeStep is a no-op (lower index)',
      () async {
    // The notifier bumps unconditionally — the store decides whether to
    // persist. That's intentional: a rebuild after any interaction is safe,
    // persisting a regression is not.
    final notifier = await _build();
    notifier.completeStep('shahada', 5);
    final before = notifier.store.getCompletedStep('shahada');
    notifier.completeStep('shahada', 1);
    expect(notifier.store.getCompletedStep('shahada'), before);
    expect(notifier.state, 2);
  });
}

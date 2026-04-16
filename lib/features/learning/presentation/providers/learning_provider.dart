import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/learning_progress_store.dart';

final learningProgressProvider = Provider<LearningProgressStore>((ref) {
  // This will be overridden in main.dart with the actual SharedPreferences instance
  throw UnimplementedError('Must be overridden');
});

/// Notifier that triggers UI rebuilds when progress changes.
final learningStateProvider =
    StateNotifierProvider<LearningStateNotifier, int>((ref) {
  return LearningStateNotifier(ref.watch(learningProgressProvider));
});

class LearningStateNotifier extends StateNotifier<int> {
  LearningStateNotifier(this._store) : super(0);
  final LearningProgressStore _store;

  LearningProgressStore get store => _store;

  void completeStep(String lessonId, int stepIndex) {
    _store.completeStep(lessonId, stepIndex);
    state++; // trigger rebuild
  }

  void startLearning() {
    _store.hasStarted = true;
    state++;
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

class HapticService {
  const HapticService();

  Future<void> lightImpact() => HapticFeedback.lightImpact();

  Future<void> mediumImpact() => HapticFeedback.mediumImpact();

  Future<void> heavyImpact() => HapticFeedback.heavyImpact();

  Future<void> selectionClick() => HapticFeedback.selectionClick();

  Future<void> warning() => HapticFeedback.mediumImpact();

  Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }

  Future<void> completion() => Vibration.vibrate(duration: 600, amplitude: 255);

  Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.mediumImpact();
  }

  Future<void> vibrate({int duration = 500, int amplitude = -1}) async {
    await Vibration.vibrate(duration: duration, amplitude: amplitude);
  }

  Future<void> cancel() async {
    await Vibration.cancel();
  }
}

final hapticServiceProvider = Provider<HapticService>(
  (_) => const HapticService(),
);

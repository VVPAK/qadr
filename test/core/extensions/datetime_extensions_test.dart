import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/extensions/datetime_extensions.dart';

void main() {
  group('DateTimeX.timeString', () {
    test('pads hours and minutes to two digits', () {
      expect(DateTime(2026, 1, 1, 5, 3).timeString, '05:03');
      expect(DateTime(2026, 1, 1, 12, 0).timeString, '12:00');
      expect(DateTime(2026, 1, 1, 23, 59).timeString, '23:59');
    });

    test('midnight is 00:00', () {
      expect(DateTime(2026, 1, 1, 0, 0).timeString, '00:00');
    });
  });

  group('DateTimeX.isToday', () {
    test('returns true for today at noon (safe from midnight boundary)', () {
      final now = DateTime.now();
      final todayNoon = DateTime(now.year, now.month, now.day, 12, 0);
      expect(todayNoon.isToday, isTrue);
    });

    test('returns false for a date in the distant past', () {
      expect(DateTime(2000, 1, 1).isToday, isFalse);
    });

    test('returns false for a date in the distant future', () {
      expect(DateTime(2099, 12, 31).isToday, isFalse);
    });
  });

  group('DateTimeX.timeUntil', () {
    test('is negative for a fixed time in the past', () {
      expect(DateTime(2000, 1, 1).timeUntil.isNegative, isTrue);
    });

    test('is positive for a fixed time in the future', () {
      expect(DateTime(2099, 12, 31).timeUntil.isNegative, isFalse);
    });
  });
}

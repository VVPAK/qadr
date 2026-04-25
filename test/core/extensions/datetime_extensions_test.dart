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
    test('returns true for the current date', () {
      final now = DateTime.now();
      final sameDay = DateTime(now.year, now.month, now.day, 10, 0);
      expect(sameDay.isToday, isTrue);
    });

    test('returns false for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isToday, isFalse);
    });

    test('returns false for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(tomorrow.isToday, isFalse);
    });
  });

  group('DateTimeX.timeUntil', () {
    test('is negative for a time in the past', () {
      final past = DateTime.now().subtract(const Duration(hours: 1));
      expect(past.timeUntil.isNegative, isTrue);
    });

    test('is positive for a time in the future', () {
      final future = DateTime.now().add(const Duration(hours: 1));
      expect(future.timeUntil.isNegative, isFalse);
    });
  });
}

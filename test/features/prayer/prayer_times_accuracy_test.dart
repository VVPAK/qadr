// Prayer time accuracy tests — 2026-04-24
//
// Expected values sourced from the AlAdhan API (api.aladhan.com/v1/timings)
// using the same calculation methods that PrayerTimesService selects
// automatically from coordinates. All comparisons are done in UTC so the
// test result is independent of the machine's local timezone.
//
// Tolerance: +-5 minutes. Real-world apps typically accept +-1-2 min; we use
// 5 min to account for minor implementation differences between adhan_dart
// and the AlAdhan API reference implementation.

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/models/prayer_time_model.dart';
import 'package:qadr/features/prayer/domain/prayer_times_service.dart';

// AlAdhan API reference date
final _kDate = DateTime.utc(2026, 4, 24);

// 5-minute tolerance: adhan_dart and AlAdhan API implement the same algorithm
// but differ slightly in intermediate rounding — 5 min covers this variance
// while still catching major calculation errors.
const _kToleranceMin = 5;
const _kToleranceMs = _kToleranceMin * 60 * 1000;

/// Asserts [actual] is within [_kToleranceMin] minutes of [expectedUtc].
void _expect(DateTime actual, DateTime expectedUtc, String label) {
  final diffMs =
      (actual.toUtc().millisecondsSinceEpoch - expectedUtc.millisecondsSinceEpoch).abs();
  expect(
    diffMs,
    lessThanOrEqualTo(_kToleranceMs),
    reason: '$label: got ${actual.toUtc().toIso8601String()}, '
        'expected ${expectedUtc.toIso8601String()} +/-$_kToleranceMin min '
        '(actual diff: ${diffMs ~/ 60000} min)',
  );
}

void main() {
  final service = PrayerTimesService();

  // -----------------------------------------------------------------------
  // Mecca, Saudi Arabia — Umm al-Qura method, UTC+3
  //
  // AlAdhan (method 4):
  //   Fajr 04:35 | Sunrise 05:55 | Dhuhr 12:19 | Asr 15:41 | Maghrib 18:43 | Isha 20:13
  //
  // Umm al-Qura specifics:
  //   * Fajr 90 min before sunrise
  //   * Isha FIXED at Maghrib + 90 min (no twilight angle)
  // -----------------------------------------------------------------------
  group('Mecca, Saudi Arabia — Umm al-Qura (UTC+3)', () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: 21.4225, longitude: 39.8262, date: _kDate));

    test('Fajr ≈ 04:35 AST = 01:35 UTC',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 24, 1, 35), 'Fajr'));
    test('Sunrise ≈ 05:55 AST = 02:55 UTC',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 24, 2, 55), 'Sunrise'));
    test('Dhuhr ≈ 12:19 AST = 09:19 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 9, 19), 'Dhuhr'));
    test('Asr ≈ 15:41 AST = 12:41 UTC',
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 12, 41), 'Asr'));
    test('Maghrib ≈ 18:43 AST = 15:43 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 15, 43), 'Maghrib'));
    test('Isha ≈ 20:13 AST = 17:13 UTC',
        () => _expect(m.isha, DateTime.utc(2026, 4, 24, 17, 13), 'Isha'));

    // Umm al-Qura invariant: Isha = Maghrib + 90 min (+-2 min for rounding)
    test('Isha = Maghrib + 90 min (Umm al-Qura fixed offset)', () {
      final diff = m.isha.toUtc().difference(m.maghrib.toUtc()).inMinutes;
      expect(diff, closeTo(90, 2), reason: 'Umm al-Qura always uses 90-min Isha offset');
    });
  });

  // -----------------------------------------------------------------------
  // Istanbul, Turkey — Diyanet method, UTC+3
  //
  // AlAdhan (method 13):
  //   Fajr 04:30 | Sunrise 06:05 | Dhuhr 13:07 | Asr 16:54 | Maghrib 20:00 | Isha 21:29
  // -----------------------------------------------------------------------
  group('Istanbul, Turkey — Diyanet (UTC+3)', () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: 41.0082, longitude: 28.9784, date: _kDate));

    test('Fajr ≈ 04:30 TRT = 01:30 UTC',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 24, 1, 30), 'Fajr'));
    test('Sunrise ≈ 06:05 TRT = 03:05 UTC',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 24, 3, 5), 'Sunrise'));
    test('Dhuhr ≈ 13:07 TRT = 10:07 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 10, 7), 'Dhuhr'));
    test('Asr ≈ 16:54 TRT = 13:54 UTC',
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 13, 54), 'Asr'));
    test('Maghrib ≈ 20:00 TRT = 17:00 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 17, 0), 'Maghrib'));
    test('Isha ≈ 21:29 TRT = 18:29 UTC',
        () => _expect(m.isha, DateTime.utc(2026, 4, 24, 18, 29), 'Isha'));
  });

  // -----------------------------------------------------------------------
  // Kazan, Russia — Muslim World League, Hanafi madhab, UTC+3
  //
  // AlAdhan (method 3, school 1 Hanafi):
  //   Fajr 01:32 | Sunrise 04:17 | Dhuhr 11:42 | Asr 16:43 | Maghrib 19:08 | Isha 21:43
  //
  // At 56N in late April, days are ~18h long. Fajr 01:32 local = 22:32 UTC
  // on the *previous* UTC date — this is correct and expected.
  // -----------------------------------------------------------------------
  group('Kazan, Russia — MWL Hanafi (UTC+3)', () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: 55.7879, longitude: 49.1233, date: _kDate));

    test('Fajr ≈ 01:32 MSK = 22:32 UTC (2026-04-23)',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 23, 22, 32), 'Fajr'));
    test('Sunrise ≈ 04:17 MSK = 01:17 UTC',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 24, 1, 17), 'Sunrise'));
    test('Dhuhr ≈ 11:42 MSK = 08:42 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 8, 42), 'Dhuhr'));
    test('Asr ≈ 16:43 MSK = 13:43 UTC (Hanafi — later than standard)',
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 13, 43), 'Asr'));
    test('Maghrib ≈ 19:08 MSK = 16:08 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 16, 8), 'Maghrib'));
    test('Isha ≈ 21:43 MSK = 18:43 UTC',
        () => _expect(m.isha, DateTime.utc(2026, 4, 24, 18, 43), 'Isha'));
  });

  // -----------------------------------------------------------------------
  // Jakarta, Indonesia — Singapore/MUIS method, Shafi'i madhab, UTC+7
  //
  // AlAdhan (method 11):
  //   Fajr 04:34 | Sunrise 05:53 | Dhuhr 11:51 | Asr 15:12 | Maghrib 17:48 | Isha 18:59
  //
  // UTC+7: Fajr and Sunrise fall on the *previous* UTC date.
  // -----------------------------------------------------------------------
  group("Jakarta, Indonesia — Singapore/MUIS Shafi'i (UTC+7)", () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: -6.2088, longitude: 106.8456, date: _kDate));

    test('Fajr ≈ 04:34 WIB = 21:34 UTC (2026-04-23)',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 23, 21, 34), 'Fajr'));
    test('Sunrise ≈ 05:53 WIB = 22:53 UTC (2026-04-23)',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 23, 22, 53), 'Sunrise'));
    test('Dhuhr ≈ 11:51 WIB = 04:51 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 4, 51), 'Dhuhr'));
    test("Asr ≈ 15:12 WIB = 08:12 UTC (Shafi'i standard shadow)",
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 8, 12), 'Asr'));
    test('Maghrib ≈ 17:48 WIB = 10:48 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 10, 48), 'Maghrib'));
    test('Isha ≈ 18:59 WIB = 11:59 UTC',
        () => _expect(m.isha, DateTime.utc(2026, 4, 24, 11, 59), 'Isha'));
  });

  // -----------------------------------------------------------------------
  // New York, USA — ISNA method, UTC-4 (EDT)
  //
  // AlAdhan (method 2):
  //   Fajr 04:41 | Sunrise 06:04 | Dhuhr 12:54 | Asr 16:42 | Maghrib 19:45 | Isha 21:08
  //
  // Isha 21:08 EDT = 01:08 UTC (next UTC date 2026-04-25).
  // -----------------------------------------------------------------------
  group('New York, USA — ISNA (UTC-4 EDT)', () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: 40.7128, longitude: -74.0060, date: _kDate));

    test('Fajr ≈ 04:41 EDT = 08:41 UTC',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 24, 8, 41), 'Fajr'));
    test('Sunrise ≈ 06:04 EDT = 10:04 UTC',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 24, 10, 4), 'Sunrise'));
    test('Dhuhr ≈ 12:54 EDT = 16:54 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 16, 54), 'Dhuhr'));
    test('Asr ≈ 16:42 EDT = 20:42 UTC',
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 20, 42), 'Asr'));
    test('Maghrib ≈ 19:45 EDT = 23:45 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 23, 45), 'Maghrib'));
    // Isha crosses the UTC midnight boundary
    test('Isha ≈ 21:08 EDT = 01:08 UTC (2026-04-25)',
        () => _expect(m.isha, DateTime.utc(2026, 4, 25, 1, 8), 'Isha'));
  });

  // -----------------------------------------------------------------------
  // Karachi, Pakistan — Karachi/UISK method, Hanafi madhab, UTC+5
  //
  // AlAdhan (method 1, school 1 Hanafi):
  //   Fajr 04:42 | Sunrise 06:02 | Dhuhr 12:30 | Asr 17:06 | Maghrib 18:58 | Isha 20:19
  //
  // Fajr 04:42 PKT = 23:42 UTC (previous UTC date).
  // -----------------------------------------------------------------------
  group('Karachi, Pakistan — Karachi/UISK Hanafi (UTC+5)', () {
    late PrayerTimeModel m;
    setUpAll(
        () => m = service.calculate(latitude: 24.8607, longitude: 67.0011, date: _kDate));

    test('Fajr ≈ 04:42 PKT = 23:42 UTC (2026-04-23)',
        () => _expect(m.fajr, DateTime.utc(2026, 4, 23, 23, 42), 'Fajr'));
    test('Sunrise ≈ 06:02 PKT = 01:02 UTC',
        () => _expect(m.sunrise, DateTime.utc(2026, 4, 24, 1, 2), 'Sunrise'));
    test('Dhuhr ≈ 12:30 PKT = 07:30 UTC',
        () => _expect(m.dhuhr, DateTime.utc(2026, 4, 24, 7, 30), 'Dhuhr'));
    test('Asr ≈ 17:06 PKT = 12:06 UTC (Hanafi, later than standard)',
        () => _expect(m.asr, DateTime.utc(2026, 4, 24, 12, 6), 'Asr'));
    test('Maghrib ≈ 18:58 PKT = 13:58 UTC',
        () => _expect(m.maghrib, DateTime.utc(2026, 4, 24, 13, 58), 'Maghrib'));
    test('Isha ≈ 20:19 PKT = 15:19 UTC',
        () => _expect(m.isha, DateTime.utc(2026, 4, 24, 15, 19), 'Isha'));
  });

  // -----------------------------------------------------------------------
  // Cross-location invariants
  // -----------------------------------------------------------------------
  group('Cross-location invariants', () {
    test('Hanafi Asr-from-Dhuhr gap > standard (Shafi\'i) gap at comparable latitudes', () {
      // Kazan (Hanafi, MWL) vs New York (standard/ISNA) at similar latitudes (~41-56N).
      // Hanafi shadow factor x2 makes Asr later relative to Dhuhr than standard x1.
      final kazan = service.calculate(latitude: 55.7879, longitude: 49.1233, date: _kDate);
      final newYork = service.calculate(latitude: 40.7128, longitude: -74.0060, date: _kDate);

      final kazanGap = kazan.asr.difference(kazan.dhuhr);
      final nyGap = newYork.asr.difference(newYork.dhuhr);

      expect(kazanGap, greaterThan(nyGap),
          reason: 'Hanafi Asr (shadow x2) should be further from Dhuhr than ISNA standard');
    });

    test('Umm al-Qura Isha is always Maghrib + 90 min', () {
      final mecca = service.calculate(latitude: 21.4225, longitude: 39.8262, date: _kDate);
      final gapMin = mecca.isha.difference(mecca.maghrib).inMinutes;
      expect(gapMin, closeTo(90, 2));
    });

    test('Diyanet (Turkey) Isha-Maghrib gap is twilight-based, in range 60-180 min', () {
      final istanbul = service.calculate(latitude: 41.0082, longitude: 28.9784, date: _kDate);
      final gapMin = istanbul.isha.difference(istanbul.maghrib).inMinutes;
      expect(gapMin, greaterThan(60));
      expect(gapMin, lessThan(180));
    });

    test('All 6 prayers are strictly ordered at every tested location', () {
      final locations = [
        (21.4225, 39.8262, 'Mecca'),
        (41.0082, 28.9784, 'Istanbul'),
        (55.7879, 49.1233, 'Kazan'),
        (-6.2088, 106.8456, 'Jakarta'),
        (40.7128, -74.0060, 'New York'),
        (24.8607, 67.0011, 'Karachi'),
      ];

      for (final (lat, lng, city) in locations) {
        final p = service.calculate(latitude: lat, longitude: lng, date: _kDate);
        expect(p.fajr.isBefore(p.sunrise), isTrue, reason: '$city: fajr < sunrise');
        expect(p.sunrise.isBefore(p.dhuhr), isTrue, reason: '$city: sunrise < dhuhr');
        expect(p.dhuhr.isBefore(p.asr), isTrue, reason: '$city: dhuhr < asr');
        expect(p.asr.isBefore(p.maghrib), isTrue, reason: '$city: asr < maghrib');
        expect(p.maghrib.isBefore(p.isha), isTrue, reason: '$city: maghrib < isha');
      }
    });
  });
}

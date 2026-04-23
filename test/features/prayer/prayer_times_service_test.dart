import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/core/models/prayer_time_model.dart';
import 'package:qadr/features/prayer/domain/prayer_times_service.dart';

void main() {
  group('PrayerTimesService.calculate', () {
    final service = PrayerTimesService();

    test('returns six ordered prayer times for a real location and date', () {
      // Mecca on a fixed day.
      final model = service.calculate(
        latitude: 21.4225,
        longitude: 39.8262,
        date: DateTime.utc(2026, 4, 23),
      );

      expect(model.fajr.isBefore(model.sunrise), isTrue);
      expect(model.sunrise.isBefore(model.dhuhr), isTrue);
      expect(model.dhuhr.isBefore(model.asr), isTrue);
      expect(model.asr.isBefore(model.maghrib), isTrue);
      expect(model.maghrib.isBefore(model.isha), isTrue);
    });

    test('all prayer times share the same calendar date as the requested day',
        () {
      final target = DateTime.utc(2026, 4, 23);
      final model = service.calculate(
        latitude: 21.4225,
        longitude: 39.8262,
        date: target,
      );

      // All prayer instants must fall within a 24h window of the requested day
      // regardless of local timezone conversion.
      for (final time in [
        model.fajr,
        model.sunrise,
        model.dhuhr,
        model.asr,
        model.maghrib,
        model.isha,
      ]) {
        final diff = time.difference(target).inHours.abs();
        expect(diff, lessThan(36),
            reason: 'prayer time $time too far from target $target');
      }
      expect(model.date, target);
    });

    test('defaults to today when no date is passed', () {
      final before = DateTime.now();
      final model = service.calculate(latitude: 21.4225, longitude: 39.8262);
      final after = DateTime.now();
      expect(
        !model.date.isBefore(before) && !model.date.isAfter(after),
        isTrue,
      );
    });

    test('returns different prayer times for different locations on the same day',
        () {
      final date = DateTime.utc(2026, 4, 23);
      final mecca = service.calculate(
        latitude: 21.4225,
        longitude: 39.8262,
        date: date,
      );
      final london = service.calculate(
        latitude: 51.5074,
        longitude: -0.1278,
        date: date,
      );
      expect(
        mecca.fajr.toUtc().millisecondsSinceEpoch,
        isNot(london.fajr.toUtc().millisecondsSinceEpoch),
      );
    });
  });

  group('PrayerTimesService.madhabForLocation', () {
    test('Istanbul (Turkey) → Hanafi', () {
      expect(PrayerTimesService.madhabForLocation(41.01, 28.97), Madhab.hanafi);
    });

    test('Karachi (Pakistan) → Hanafi', () {
      expect(PrayerTimesService.madhabForLocation(24.86, 67.00), Madhab.hanafi);
    });

    test('Delhi (India) → Hanafi', () {
      expect(PrayerTimesService.madhabForLocation(28.61, 77.20), Madhab.hanafi);
    });

    test('Tashkent (Central Asia) → Hanafi', () {
      expect(PrayerTimesService.madhabForLocation(41.31, 69.24), Madhab.hanafi);
    });

    test('Kazan (Russia) → Hanafi', () {
      expect(PrayerTimesService.madhabForLocation(55.78, 49.12), Madhab.hanafi);
    });

    test('Casablanca (Morocco) → Maliki', () {
      expect(PrayerTimesService.madhabForLocation(33.57, -7.58), Madhab.maliki);
    });

    test('Algiers (North Africa) → Maliki', () {
      expect(PrayerTimesService.madhabForLocation(36.75, 3.06), Madhab.maliki);
    });

    test('Mecca (Arabian Peninsula) → Hanbali', () {
      expect(
          PrayerTimesService.madhabForLocation(21.42, 39.83), Madhab.hanbali);
    });

    test('Jakarta (SE Asia) → Shafii', () {
      expect(PrayerTimesService.madhabForLocation(-6.21, 106.85), Madhab.shafii);
    });

    test('Unmapped region falls back to Shafii', () {
      // Mid-Pacific, clearly in no region.
      expect(
          PrayerTimesService.madhabForLocation(0.0, -150.0), Madhab.shafii);
      // Antarctic ocean.
      expect(
          PrayerTimesService.madhabForLocation(-60.0, 0.0), Madhab.shafii);
    });
  });

  group('PrayerTimesService.toComponentData', () {
    final service = PrayerTimesService();

    PrayerTimeModel buildModel({
      required DateTime fajr,
      required DateTime sunrise,
      required DateTime dhuhr,
      required DateTime asr,
      required DateTime maghrib,
      required DateTime isha,
      DateTime? date,
    }) {
      return PrayerTimeModel(
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        maghrib: maghrib,
        isha: isha,
        date: date ?? fajr,
      );
    }

    test('emits six prayers in canonical order with HH:mm times', () {
      final day = DateTime.now().add(const Duration(days: 1));
      final base = DateTime(day.year, day.month, day.day);
      final model = buildModel(
        fajr: base.add(const Duration(hours: 5, minutes: 3)),
        sunrise: base.add(const Duration(hours: 6, minutes: 12)),
        dhuhr: base.add(const Duration(hours: 12, minutes: 30)),
        asr: base.add(const Duration(hours: 15, minutes: 45)),
        maghrib: base.add(const Duration(hours: 18, minutes: 9)),
        isha: base.add(const Duration(hours: 19, minutes: 55)),
      );

      final data = service.toComponentData(model);
      expect(data.prayers.map((p) => p.name).toList(),
          ['fajr', 'sunrise', 'dhuhr', 'asr', 'maghrib', 'isha']);
      expect(data.prayers.map((p) => p.time).toList(),
          ['05:03', '06:12', '12:30', '15:45', '18:09', '19:55']);
    });

    test('formats date as yyyy-MM-dd with zero-padding', () {
      final model = buildModel(
        fajr: DateTime(2026, 1, 5, 5, 0),
        sunrise: DateTime(2026, 1, 5, 6, 0),
        dhuhr: DateTime(2026, 1, 5, 12, 0),
        asr: DateTime(2026, 1, 5, 15, 0),
        maghrib: DateTime(2026, 1, 5, 18, 0),
        isha: DateTime(2026, 1, 5, 19, 0),
        date: DateTime(2026, 1, 5),
      );
      expect(service.toComponentData(model).date, '2026-01-05');
    });

    test('marks the first upcoming prayer as isNext', () {
      // All prayers in the future → fajr should be "next".
      final inFuture = DateTime.now().add(const Duration(days: 1));
      final model = buildModel(
        fajr: inFuture.add(const Duration(hours: 1)),
        sunrise: inFuture.add(const Duration(hours: 2)),
        dhuhr: inFuture.add(const Duration(hours: 3)),
        asr: inFuture.add(const Duration(hours: 4)),
        maghrib: inFuture.add(const Duration(hours: 5)),
        isha: inFuture.add(const Duration(hours: 6)),
      );

      final data = service.toComponentData(model);
      expect(data.prayers.first.isNext, isTrue);
      expect(data.prayers.where((p) => p.isNext).length, 1);
      expect(data.prayers.first.name, 'fajr');
    });

    test('marks only the first future prayer when earlier ones have passed',
        () {
      // fajr + sunrise in the past, dhuhr+ in the future → dhuhr isNext.
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final future = DateTime.now().add(const Duration(hours: 2));
      final model = buildModel(
        fajr: past.subtract(const Duration(hours: 2)),
        sunrise: past,
        dhuhr: future,
        asr: future.add(const Duration(hours: 1)),
        maghrib: future.add(const Duration(hours: 2)),
        isha: future.add(const Duration(hours: 3)),
      );

      final data = service.toComponentData(model);
      expect(data.prayers.where((p) => p.isNext).map((p) => p.name).toList(),
          ['dhuhr']);
    });

    test('marks no prayer as next when every time is in the past', () {
      final past = DateTime.now().subtract(const Duration(days: 1));
      final model = buildModel(
        fajr: past,
        sunrise: past.add(const Duration(hours: 1)),
        dhuhr: past.add(const Duration(hours: 2)),
        asr: past.add(const Duration(hours: 3)),
        maghrib: past.add(const Duration(hours: 4)),
        isha: past.add(const Duration(hours: 5)),
      );

      final data = service.toComponentData(model);
      expect(data.prayers.any((p) => p.isNext), isFalse);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';

void main() {
  group('Madhab.displayName', () {
    test('every value has a non-empty display name', () {
      for (final m in Madhab.values) {
        expect(m.displayName, isNotEmpty, reason: m.name);
      }
    });

    test('hanafi → Hanafi', () => expect(Madhab.hanafi.displayName, 'Hanafi'));
    test(
      "shafii → Shafi'i",
      () => expect(Madhab.shafii.displayName, "Shafi'i"),
    );
    test('maliki → Maliki', () => expect(Madhab.maliki.displayName, 'Maliki'));
    test(
      'hanbali → Hanbali',
      () => expect(Madhab.hanbali.displayName, 'Hanbali'),
    );
  });

  group('PrayerName.displayName', () {
    test('every value has a non-empty display name', () {
      for (final p in PrayerName.values) {
        expect(p.displayName, isNotEmpty, reason: p.name);
      }
    });

    test('fajr → Fajr', () => expect(PrayerName.fajr.displayName, 'Fajr'));
    test(
      'sunrise → Sunrise',
      () => expect(PrayerName.sunrise.displayName, 'Sunrise'),
    );
    test('dhuhr → Dhuhr', () => expect(PrayerName.dhuhr.displayName, 'Dhuhr'));
    test('asr → Asr', () => expect(PrayerName.asr.displayName, 'Asr'));
    test(
      'maghrib → Maghrib',
      () => expect(PrayerName.maghrib.displayName, 'Maghrib'),
    );
    test('isha → Isha', () => expect(PrayerName.isha.displayName, 'Isha'));
  });

  group('ChatIntent values', () {
    test('has 7 values covering all expected intents', () {
      expect(ChatIntent.values, hasLength(7));
    });

    test('contains all expected intents', () {
      final names = ChatIntent.values.map((e) => e.name).toSet();
      expect(
        names,
        containsAll([
          'prayerTime',
          'quranSearch',
          'duaRequest',
          'tasbih',
          'qibla',
          'learning',
          'generalQuestion',
        ]),
      );
    });
  });
}

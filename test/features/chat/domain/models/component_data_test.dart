import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/component_data.dart';

ComponentData _jsonRoundTrip(ComponentData original) {
  final encoded = jsonEncode(original.toJson());
  return ComponentData.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
}

void main() {
  group('ComponentData.fromJson union dispatch', () {
    test('dispatches to PrayerTimesData on runtimeType "prayerTimes"', () {
      final data = ComponentData.fromJson({
        'runtimeType': 'prayerTimes',
        'prayers': [
          {'name': 'fajr', 'time': '05:03', 'isNext': true},
          {'name': 'dhuhr', 'time': '12:30'},
        ],
        'date': '2026-04-23',
      });
      expect(data, isA<PrayerTimesData>());
      data as PrayerTimesData;
      expect(data.date, '2026-04-23');
      expect(data.prayers, hasLength(2));
      expect(data.prayers.first.name, 'fajr');
      expect(data.prayers.first.isNext, isTrue);
      expect(data.prayers.last.isNext, isFalse,
          reason: 'isNext defaults to false when omitted');
    });

    test('dispatches to QuranAyahData on runtimeType "quranAyah"', () {
      final data = ComponentData.fromJson({
        'runtimeType': 'quranAyah',
        'ayahs': [
          {
            'surah': 1,
            'ayah': 1,
            'arabic': 'بسم الله',
            'translation': 'In the name of Allah',
          }
        ],
      });
      expect(data, isA<QuranAyahData>());
      data as QuranAyahData;
      expect(data.ayahs, hasLength(1));
      expect(data.ayahs.single.surah, 1);
      expect(data.ayahs.single.ayah, 1);
      expect(data.ayahs.single.arabic, 'بسم الله');
    });

    test('dispatches to DuaData on runtimeType "dua"', () {
      final data = ComponentData.fromJson({
        'runtimeType': 'dua',
        'arabic': 'رَبِّ زِدْنِي عِلْمًا',
        'transliteration': 'Rabbi zidni ilma',
        'translation': 'My Lord, increase me in knowledge.',
        'source': 'Quran 20:114',
      });
      expect(data, isA<DuaData>());
      data as DuaData;
      expect(data.source, 'Quran 20:114');
      expect(data.transliteration, 'Rabbi zidni ilma');
    });

    test('dispatches to TasbihData on runtimeType "tasbih"', () {
      final data = ComponentData.fromJson({
        'runtimeType': 'tasbih',
        'dhikrText': 'SubhanAllah',
        'targetCount': 33,
      });
      expect(data, isA<TasbihData>());
      data as TasbihData;
      expect(data.dhikrText, 'SubhanAllah');
      expect(data.targetCount, 33);
    });

    test('TasbihData.targetCount defaults to 33 when omitted', () {
      final data = ComponentData.fromJson({
        'runtimeType': 'tasbih',
        'dhikrText': 'Alhamdulillah',
      });
      data as TasbihData;
      expect(data.targetCount, 33);
    });

    test('dispatches to QiblaData on runtimeType "qibla"', () {
      final data = ComponentData.fromJson({'runtimeType': 'qibla'});
      expect(data, isA<QiblaData>());
    });

    test('throws on an unknown runtimeType', () {
      expect(
        () => ComponentData.fromJson({'runtimeType': 'mystery'}),
        throwsA(anything),
      );
    });

    test('throws when runtimeType is missing', () {
      expect(
        () => ComponentData.fromJson({'prayers': [], 'date': '2026-01-01'}),
        throwsA(anything),
      );
    });
  });

  group('ComponentData toJson round-trips', () {
    test('PrayerTimesData round-trips through JSON', () {
      const original = PrayerTimesData(
        prayers: [
          PrayerTimeEntry(name: 'fajr', time: '05:03', isNext: true),
          PrayerTimeEntry(name: 'isha', time: '19:55'),
        ],
        date: '2026-04-23',
      );
      expect(_jsonRoundTrip(original), original);
    });

    test('DuaData round-trips through JSON', () {
      const original = DuaData(
        arabic: 'a',
        transliteration: 't',
        translation: 'tr',
        source: 's',
      );
      expect(_jsonRoundTrip(original), original);
    });

    test('TasbihData round-trips through JSON', () {
      const original = TasbihData(dhikrText: 'SubhanAllah', targetCount: 99);
      expect(_jsonRoundTrip(original), original);
    });

    test('QiblaData round-trips through JSON', () {
      const original = QiblaData();
      expect(_jsonRoundTrip(original), original);
    });
  });
}

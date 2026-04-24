import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/database/app_database.dart';

Future<void> _insertSurah(
  AppDatabase db, {
  required int number,
  String nameArabic = 'ar',
  String nameEnglish = 'en',
  String nameRussian = 'ru',
  String revelationType = 'Meccan',
  int ayahCount = 7,
}) {
  return db.into(db.surahs).insert(
        SurahsCompanion.insert(
          number: Value(number),
          nameArabic: nameArabic,
          nameEnglish: nameEnglish,
          nameRussian: nameRussian,
          revelationType: revelationType,
          ayahCount: ayahCount,
        ),
      );
}

Future<void> _insertAyah(
  AppDatabase db, {
  required int surahNumber,
  required int ayahNumber,
  String textArabic = 'ar',
  String textEnglish = 'en',
  String textRussian = 'ru',
}) {
  return db.into(db.ayahs).insert(
        AyahsCompanion.insert(
          surahNumber: surahNumber,
          ayahNumber: ayahNumber,
          textArabic: textArabic,
          textEnglish: textEnglish,
          textRussian: textRussian,
        ),
      );
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.withExecutor(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('QuranDao.getAllSurahs', () {
    test('returns empty on empty table', () async {
      expect(await db.quranDao.getAllSurahs(), isEmpty);
    });

    test('returns all surahs ordered by number ascending', () async {
      await _insertSurah(db, number: 114);
      await _insertSurah(db, number: 2);
      await _insertSurah(db, number: 1);
      await _insertSurah(db, number: 36);

      final surahs = await db.quranDao.getAllSurahs();
      expect(surahs.map((s) => s.number).toList(), [1, 2, 36, 114]);
    });
  });

  group('QuranDao.getSurah', () {
    test('returns the surah with the matching number', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      await _insertSurah(db, number: 2, nameEnglish: 'Al-Baqarah');

      final surah = await db.quranDao.getSurah(1);
      expect(surah.nameEnglish, 'Al-Fatiha');
    });

    test('throws when no surah matches', () async {
      await _insertSurah(db, number: 1);
      expect(() => db.quranDao.getSurah(99), throwsA(anything));
    });
  });

  group('QuranDao.getAyahsForSurah', () {
    test('returns only ayahs of the requested surah, ordered by ayah number',
        () async {
      await _insertSurah(db, number: 1);
      await _insertSurah(db, number: 2);
      await _insertAyah(db, surahNumber: 1, ayahNumber: 3);
      await _insertAyah(db, surahNumber: 1, ayahNumber: 1);
      await _insertAyah(db, surahNumber: 1, ayahNumber: 2);
      await _insertAyah(db, surahNumber: 2, ayahNumber: 1);

      final ayahs = await db.quranDao.getAyahsForSurah(1);
      expect(ayahs.map((a) => a.ayahNumber).toList(), [1, 2, 3]);
    });

    test('returns empty when the surah has no ayahs', () async {
      await _insertSurah(db, number: 1);
      expect(await db.quranDao.getAyahsForSurah(1), isEmpty);
    });
  });

  group('QuranDao.getAyah', () {
    test('returns the exact ayah by (surah, ayah) composite key', () async {
      await _insertSurah(db, number: 1);
      await _insertAyah(db,
          surahNumber: 1, ayahNumber: 1, textEnglish: 'In the name');
      await _insertAyah(db,
          surahNumber: 1, ayahNumber: 2, textEnglish: 'Praise be');

      final ayah = await db.quranDao.getAyah(1, 2);
      expect(ayah.textEnglish, 'Praise be');
    });

    test('throws when the composite key does not exist', () async {
      await _insertSurah(db, number: 1);
      expect(() => db.quranDao.getAyah(1, 999), throwsA(anything));
    });
  });

  group('QuranDao.searchAyahs', () {
    setUp(() async {
      await _insertSurah(db, number: 1);
      await _insertAyah(db,
          surahNumber: 1,
          ayahNumber: 1,
          textArabic: 'بسم الله',
          textEnglish: 'In the name of Allah',
          textRussian: 'Именем Аллаха');
      await _insertAyah(db,
          surahNumber: 1,
          ayahNumber: 2,
          textArabic: 'الحمد لله',
          textEnglish: 'Praise be to Allah',
          textRussian: 'Хвала Аллаху');
    });

    test('ar language matches only Arabic column', () async {
      final hits = await db.quranDao.searchAyahs('الحمد', 'ar');
      expect(hits, hasLength(1));
      expect(hits.single.ayahNumber, 2);
    });

    test('ru language matches only Russian column', () async {
      final hits = await db.quranDao.searchAyahs('Хвала', 'ru');
      expect(hits, hasLength(1));
      expect(hits.single.ayahNumber, 2);
    });

    test('unknown language falls back to English OR Arabic', () async {
      final english =
          await db.quranDao.searchAyahs('Praise', 'en');
      expect(english, hasLength(1));
      expect(english.single.ayahNumber, 2);

      // Arabic query in English-fallback mode still matches because the
      // fallback branch ORs against textArabic.
      final arabic = await db.quranDao.searchAyahs('بسم', 'en');
      expect(arabic, hasLength(1));
      expect(arabic.single.ayahNumber, 1);
    });

    test('caps results at 20', () async {
      await _insertSurah(db, number: 2, ayahCount: 30);
      for (var i = 1; i <= 30; i++) {
        await _insertAyah(db,
            surahNumber: 2,
            ayahNumber: i,
            textEnglish: 'abundance $i');
      }
      final hits = await db.quranDao.searchAyahs('abundance', 'en');
      expect(hits, hasLength(20));
    });

    test('returns empty when no ayah matches', () async {
      final hits = await db.quranDao.searchAyahs('noresult', 'en');
      expect(hits, isEmpty);
    });
  });
}

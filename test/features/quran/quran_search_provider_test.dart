import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/database/app_database.dart';
import 'package:qadr/core/providers/database_provider.dart';
import 'package:qadr/features/quran/presentation/providers/quran_providers.dart';

// Helpers reused from quran_dao_test.dart pattern
Future<void> _insertSurah(
  AppDatabase db, {
  required int number,
  String nameArabic = 'سورة',
  String nameEnglish = 'Surah',
  String nameRussian = 'Сура',
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
  String textArabic = 'عربي',
  String textEnglish = 'english',
  String textRussian = 'русский',
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

AppDatabase _makeDb() =>
    AppDatabase.withExecutor(NativeDatabase.memory(setup: AppDatabase.setupDatabase));

ProviderContainer _makeContainer(AppDatabase db) {
  return ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(db),
      quranInitProvider.overrideWith((ref) async {}),
    ],
  );
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = _makeDb();
    container = _makeContainer(db);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  Future<QuranSearchResults> getResults(String language) async {
    final result = await container.read(quranSearchProvider(language).future);
    return result;
  }

  group('quranSearchProvider', () {
    test('empty query returns empty results', () async {
      container.read(quranSearchQueryProvider.notifier).state = '';
      final results = await getResults('en');
      expect(results.isEmpty, isTrue);
      expect(results.surahs, isEmpty);
      expect(results.ayahs, isEmpty);
    });

    test('single-char query returns empty results', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      container.read(quranSearchQueryProvider.notifier).state = 'a';
      final results = await getResults('en');
      expect(results.isEmpty, isTrue);
    });

    test('matches surah by English name', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      await _insertSurah(db, number: 2, nameEnglish: 'Al-Baqarah');
      container.read(quranSearchQueryProvider.notifier).state = 'fati';
      final results = await getResults('en');
      expect(results.surahs, hasLength(1));
      expect(results.surahs.single.number, 1);
      expect(results.ayahs, isEmpty);
    });

    test('matches surah by Arabic name when language is ar', () async {
      await _insertSurah(db, number: 1, nameArabic: 'الفاتحة');
      await _insertSurah(db, number: 2, nameArabic: 'البقرة');
      container.read(quranSearchQueryProvider.notifier).state = 'فاتحة';
      final results = await getResults('ar');
      expect(results.surahs, hasLength(1));
      expect(results.surahs.single.number, 1);
    });

    test('matches surah by Russian name when language is ru', () async {
      await _insertSurah(db, number: 1, nameRussian: 'Аль-Фатиха');
      await _insertSurah(db, number: 2, nameRussian: 'Аль-Бакара');
      container.read(quranSearchQueryProvider.notifier).state = 'Фатиха';
      final results = await getResults('ru');
      expect(results.surahs, hasLength(1));
      expect(results.surahs.single.number, 1);
    });

    test('ayah matches delegate to DAO', () async {
      await _insertSurah(db, number: 1);
      await _insertAyah(
          db, surahNumber: 1, ayahNumber: 1, textEnglish: 'Praise be to Allah');
      await _insertAyah(
          db, surahNumber: 1, ayahNumber: 2, textEnglish: 'In the name of Allah');
      container.read(quranSearchQueryProvider.notifier).state = 'Allah';
      final results = await getResults('en');
      expect(results.ayahs, hasLength(2));
    });

    test('combined: surah and ayah results together', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      await _insertAyah(
          db, surahNumber: 1, ayahNumber: 1, textEnglish: 'Guide us');
      container.read(quranSearchQueryProvider.notifier).state = 'al';
      final results = await getResults('en');
      // "al-fatiha" contains "al" → surah match
      expect(results.surahs, hasLength(1));
    });

    test('no match returns empty results with non-empty query', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      await _insertAyah(db, surahNumber: 1, ayahNumber: 1, textEnglish: 'Praise');
      container.read(quranSearchQueryProvider.notifier).state = 'xyz_no_match';
      final results = await getResults('en');
      expect(results.isEmpty, isTrue);
    });

    test('isEmpty is false when results exist', () async {
      await _insertSurah(db, number: 1, nameEnglish: 'Al-Fatiha');
      container.read(quranSearchQueryProvider.notifier).state = 'fati';
      final results = await getResults('en');
      expect(results.isEmpty, isFalse);
    });
  });
}

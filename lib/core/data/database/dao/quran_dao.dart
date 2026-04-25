import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/quran_tables.dart';

part 'quran_dao.g.dart';

@DriftAccessor(tables: [Surahs, Ayahs])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);

  Future<List<Surah>> getAllSurahs() =>
      (select(surahs)..orderBy([(s) => OrderingTerm.asc(s.number)])).get();

  Future<Surah> getSurah(int number) =>
      (select(surahs)..where((s) => s.number.equals(number))).getSingle();

  Future<List<Ayah>> getAyahsForSurah(int surahNumber) =>
      (select(ayahs)
            ..where((a) => a.surahNumber.equals(surahNumber))
            ..orderBy([(a) => OrderingTerm.asc(a.ayahNumber)]))
          .get();

  Future<Ayah> getAyah(int surahNumber, int ayahNumber) =>
      (select(ayahs)..where(
            (a) =>
                a.surahNumber.equals(surahNumber) &
                a.ayahNumber.equals(ayahNumber),
          ))
          .getSingle();

  Future<List<Ayah>> searchAyahs(String query, String language) {
    final pattern = '%${query.toLowerCase()}%';
    return (select(ayahs)
          ..where((a) {
            switch (language) {
              case 'ar':
                return a.textArabic.lower().like(pattern);
              case 'ru':
                return a.textRussian.lower().like(pattern);
              default:
                return a.textEnglish.lower().like(pattern) |
                    a.textArabic.lower().like(pattern);
            }
          })
          ..limit(20))
        .get();
  }
}

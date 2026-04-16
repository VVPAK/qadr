import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import 'app_database.dart';

class QuranDataSeeder {
  QuranDataSeeder(this._db);
  final AppDatabase _db;

  Future<bool> isSeeded() async {
    final surahs = await _db.quranDao.getAllSurahs();
    return surahs.isNotEmpty;
  }

  Future<void> seed() async {
    final jsonString = await rootBundle.loadString('assets/data/quran.json');
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    await _db.batch((batch) {
      final surahs = (data['surahs'] as List).map((s) {
        final m = s as Map<String, dynamic>;
        return SurahsCompanion.insert(
          number: Value(m['number'] as int),
          nameArabic: m['nameArabic'] as String,
          nameEnglish: m['nameEnglish'] as String,
          nameRussian: m['nameRussian'] as String,
          revelationType: m['revelationType'] as String,
          ayahCount: m['ayahCount'] as int,
        );
      }).toList();
      batch.insertAll(_db.surahs, surahs);

      final ayahs = (data['ayahs'] as List).map((a) {
        final m = a as Map<String, dynamic>;
        return AyahsCompanion.insert(
          surahNumber: m['surahNumber'] as int,
          ayahNumber: m['ayahNumber'] as int,
          textArabic: m['textArabic'] as String,
          textEnglish: m['textEnglish'] as String,
          textRussian: m['textRussian'] as String,
        );
      }).toList();
      batch.insertAll(_db.ayahs, ayahs);
    });
  }
}

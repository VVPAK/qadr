import 'package:drift/drift.dart';

class Surahs extends Table {
  IntColumn get number => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameEnglish => text()();
  TextColumn get nameRussian => text()();
  TextColumn get revelationType => text()();
  IntColumn get ayahCount => integer()();

  @override
  Set<Column> get primaryKey => {number};
}

class Ayahs extends Table {
  IntColumn get surahNumber => integer().references(Surahs, #number)();
  IntColumn get ayahNumber => integer()();
  TextColumn get textArabic => text()();
  TextColumn get textEnglish => text()();
  TextColumn get textRussian => text()();

  @override
  Set<Column> get primaryKey => {surahNumber, ayahNumber};
}

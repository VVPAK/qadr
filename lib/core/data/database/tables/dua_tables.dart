import 'package:drift/drift.dart';

class Duas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get arabic => text()();
  TextColumn get transliteration => text()();
  TextColumn get translationEn => text()();
  TextColumn get translationRu => text()();
  TextColumn get source => text()();
}

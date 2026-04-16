import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/dua_tables.dart';

part 'dua_dao.g.dart';

@DriftAccessor(tables: [Duas])
class DuaDao extends DatabaseAccessor<AppDatabase> with _$DuaDaoMixin {
  DuaDao(super.db);

  Future<List<Dua>> getAllDuas() => select(duas).get();

  Future<List<Dua>> getDuasByCategory(String category) =>
      (select(duas)..where((d) => d.category.equals(category))).get();

  Future<List<String>> getCategories() async {
    final query = selectOnly(duas, distinct: true)
      ..addColumns([duas.category]);
    final rows = await query.get();
    return rows.map((row) => row.read(duas.category)!).toList();
  }

  Future<List<Dua>> searchDuas(String query) {
    final pattern = '%$query%';
    return (select(duas)
          ..where((d) =>
              d.arabic.like(pattern) |
              d.translationEn.like(pattern) |
              d.translationRu.like(pattern))
          ..limit(20))
        .get();
  }
}

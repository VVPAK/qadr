import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/quran_tables.dart';
import 'tables/dua_tables.dart';
import 'dao/quran_dao.dart';
import 'dao/dua_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Surahs, Ayahs, Duas], daos: [QuranDao, DuaDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Injects a custom [QueryExecutor] — used by tests to run against an
  /// in-memory sqlite instance without touching the filesystem.
  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'qadr.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}

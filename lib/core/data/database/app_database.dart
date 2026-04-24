import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart' show Database, AllowedArgumentCount;

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

  /// Registers a Unicode-aware lower() function so that LOWER(text) works
  /// correctly for non-ASCII scripts (Cyrillic, Arabic, etc.). SQLite's
  /// built-in lower() only handles ASCII a-z.
  static void setupDatabase(Database db) {
    db.createFunction(
      functionName: 'lower',
      argumentCount: const AllowedArgumentCount(1),
      function: (args) => (args.first as String?)?.toLowerCase(),
      deterministic: true,
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'qadr.sqlite'));
      return NativeDatabase.createInBackground(file, setup: setupDatabase);
    });
  }
}

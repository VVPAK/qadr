import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/database/app_database.dart';

Future<int> _insertDua(
  AppDatabase db, {
  required String category,
  required String arabic,
  String transliteration = 't',
  String translationEn = 'en',
  String translationRu = 'ru',
  String source = 's',
}) {
  return db
      .into(db.duas)
      .insert(
        DuasCompanion.insert(
          category: category,
          arabic: arabic,
          transliteration: transliteration,
          translationEn: translationEn,
          translationRu: translationRu,
          source: source,
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

  group('DuaDao.getAllDuas', () {
    test('returns an empty list on an empty table', () async {
      expect(await db.duaDao.getAllDuas(), isEmpty);
    });

    test('returns every inserted dua', () async {
      await _insertDua(db, category: 'daily', arabic: 'a1');
      await _insertDua(db, category: 'daily', arabic: 'a2');
      await _insertDua(db, category: 'travel', arabic: 'a3');
      final duas = await db.duaDao.getAllDuas();
      expect(duas, hasLength(3));
    });
  });

  group('DuaDao.getDuasByCategory', () {
    test('filters by exact category match', () async {
      await _insertDua(db, category: 'morning', arabic: 'm1');
      await _insertDua(db, category: 'morning', arabic: 'm2');
      await _insertDua(db, category: 'evening', arabic: 'e1');

      final morning = await db.duaDao.getDuasByCategory('morning');
      expect(morning.map((d) => d.arabic).toSet(), {'m1', 'm2'});
    });

    test('returns empty list for unknown category', () async {
      await _insertDua(db, category: 'daily', arabic: 'a');
      expect(await db.duaDao.getDuasByCategory('missing'), isEmpty);
    });
  });

  group('DuaDao.getCategories', () {
    test('returns distinct categories only', () async {
      await _insertDua(db, category: 'daily', arabic: 'a');
      await _insertDua(db, category: 'daily', arabic: 'b');
      await _insertDua(db, category: 'travel', arabic: 'c');
      await _insertDua(db, category: 'travel', arabic: 'd');
      await _insertDua(db, category: 'morning', arabic: 'e');

      final cats = await db.duaDao.getCategories();
      expect(cats.toSet(), {'daily', 'travel', 'morning'});
    });

    test('returns empty list when there are no duas', () async {
      expect(await db.duaDao.getCategories(), isEmpty);
    });
  });

  group('DuaDao.searchDuas', () {
    test('matches on arabic column', () async {
      await _insertDua(
        db,
        category: 'daily',
        arabic: 'بسم الله الرحمن الرحيم',
        translationEn: 'In the name of Allah',
      );
      await _insertDua(db, category: 'daily', arabic: 'other');

      final hits = await db.duaDao.searchDuas('الرحمن');
      expect(hits, hasLength(1));
      expect(hits.single.arabic, contains('الرحمن'));
    });

    test('matches on English translation', () async {
      await _insertDua(
        db,
        category: 'daily',
        arabic: 'a',
        translationEn: 'Alhamdulillah',
      );
      await _insertDua(db, category: 'daily', arabic: 'b');

      final hits = await db.duaDao.searchDuas('hamdul');
      expect(hits, hasLength(1));
      expect(hits.single.translationEn, 'Alhamdulillah');
    });

    test('matches on Russian translation', () async {
      await _insertDua(
        db,
        category: 'daily',
        arabic: 'a',
        translationRu: 'Хвала Аллаху',
      );
      await _insertDua(db, category: 'daily', arabic: 'b');

      final hits = await db.duaDao.searchDuas('Хвала');
      expect(hits, hasLength(1));
    });

    test('caps results at 20', () async {
      for (var i = 0; i < 30; i++) {
        await _insertDua(db, category: 'daily', arabic: 'xx$i');
      }
      final hits = await db.duaDao.searchDuas('xx');
      expect(hits, hasLength(20));
    });

    test('returns empty list when nothing matches', () async {
      await _insertDua(db, category: 'daily', arabic: 'a');
      expect(await db.duaDao.searchDuas('wontmatch'), isEmpty);
    });
  });
}

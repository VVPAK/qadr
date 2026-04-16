import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/database/app_database.dart';
import '../../../../core/data/database/quran_data_seeder.dart';
import '../../../../core/providers/database_provider.dart';

final quranInitProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  final seeder = QuranDataSeeder(db);
  if (!await seeder.isSeeded()) {
    await seeder.seed();
  }
});

final surahListProvider = FutureProvider<List<Surah>>((ref) async {
  await ref.watch(quranInitProvider.future);
  final dao = ref.watch(quranDaoProvider);
  return dao.getAllSurahs();
});

final surahProvider = FutureProvider.family<Surah, int>((ref, surahNumber) async {
  await ref.watch(quranInitProvider.future);
  final dao = ref.watch(quranDaoProvider);
  return dao.getSurah(surahNumber);
});

final ayahsProvider =
    FutureProvider.family<List<Ayah>, int>((ref, surahNumber) async {
  await ref.watch(quranInitProvider.future);
  final dao = ref.watch(quranDaoProvider);
  return dao.getAyahsForSurah(surahNumber);
});

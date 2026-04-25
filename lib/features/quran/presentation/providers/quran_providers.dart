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

final surahProvider = FutureProvider.family<Surah, int>((
  ref,
  surahNumber,
) async {
  await ref.watch(quranInitProvider.future);
  final dao = ref.watch(quranDaoProvider);
  return dao.getSurah(surahNumber);
});

final ayahsProvider = FutureProvider.family<List<Ayah>, int>((
  ref,
  surahNumber,
) async {
  await ref.watch(quranInitProvider.future);
  final dao = ref.watch(quranDaoProvider);
  return dao.getAyahsForSurah(surahNumber);
});

const _kMinSearchLength = 2;

class QuranSearchResults {
  const QuranSearchResults({required this.surahs, required this.ayahs});

  final List<Surah> surahs;
  final List<Ayah> ayahs;

  bool get isEmpty => surahs.isEmpty && ayahs.isEmpty;
}

final quranSearchQueryProvider = StateProvider<String>((_) => '');

/// Keyed by language code ('en', 'ar', 'ru').
final quranSearchProvider = FutureProvider.family<QuranSearchResults, String>((
  ref,
  language,
) async {
  final query = ref.watch(quranSearchQueryProvider);
  if (query.trim().length < _kMinSearchLength) {
    return const QuranSearchResults(surahs: [], ayahs: []);
  }

  final allSurahs = await ref.watch(surahListProvider.future);
  final dao = ref.watch(quranDaoProvider);
  final q = query.trim().toLowerCase();

  final matchingSurahs = allSurahs.where((s) {
    return switch (language) {
      'ar' => s.nameArabic.contains(q),
      'ru' => s.nameRussian.toLowerCase().contains(q),
      _ => s.nameEnglish.toLowerCase().contains(q),
    };
  }).toList();

  final matchingAyahs = await dao.searchAyahs(query.trim(), language);

  return QuranSearchResults(surahs: matchingSurahs, ayahs: matchingAyahs);
});

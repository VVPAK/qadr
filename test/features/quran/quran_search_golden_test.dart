@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/database/app_database.dart';
import 'package:qadr/features/quran/presentation/providers/quran_providers.dart';
import 'package:qadr/features/quran/presentation/quran_list_screen.dart';

import '../../helpers/golden_test_helpers.dart';

final _fakeSurahs = List.generate(
  10,
  (i) => Surah(
    number: i + 1,
    nameArabic: 'سورة ${i + 1}',
    nameEnglish: 'Surah ${i + 1}',
    nameRussian: 'Сура ${i + 1}',
    revelationType: i.isEven ? 'Meccan' : 'Medinan',
    ayahCount: 7 + i * 3,
  ),
);

Ayah _fakeAyah(int surahNumber, int ayahNumber, String en) => Ayah(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      textArabic: 'بِسْمِ ٱللَّٰهِ',
      textEnglish: en,
      textRussian: 'Во имя Аллаха',
    );

final _fakeAyahResults = [
  _fakeAyah(1, 1, 'In the name of Allah the Most Gracious'),
  _fakeAyah(1, 2, 'All praise is due to Allah'),
  _fakeAyah(2, 5, 'Guide us to the straight path'),
];

final _fakeResults = QuranSearchResults(
  surahs: _fakeSurahs.take(2).toList(),
  ayahs: _fakeAyahResults,
);

final _emptyResults = const QuranSearchResults(surahs: [], ayahs: []);

void main() {
  goldenTest(
    'quran_list_screen_search_active',
    providerOverrides: [
      surahListProvider.overrideWith((_) async => _fakeSurahs),
      quranInitProvider.overrideWith((_) async {}),
      quranSearchQueryProvider.overrideWith((_) => 'al'),
      quranSearchProvider('en').overrideWith((_) async => _fakeResults),
      quranSearchProvider('ar').overrideWith((_) async => _fakeResults),
      quranSearchProvider('ru').overrideWith((_) async => _fakeResults),
    ],
    builder: (_) => QuranListScreen(onNavChanged: (_) {}),
  );

  goldenTest(
    'quran_list_screen_search_empty',
    providerOverrides: [
      surahListProvider.overrideWith((_) async => _fakeSurahs),
      quranInitProvider.overrideWith((_) async {}),
      quranSearchQueryProvider.overrideWith((_) => 'xyz'),
      quranSearchProvider('en').overrideWith((_) async => _emptyResults),
      quranSearchProvider('ar').overrideWith((_) async => _emptyResults),
      quranSearchProvider('ru').overrideWith((_) async => _emptyResults),
    ],
    builder: (_) => QuranListScreen(onNavChanged: (_) {}),
  );
}

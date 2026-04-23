@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/data/database/app_database.dart';
import 'package:qadr/features/quran/presentation/providers/quran_providers.dart';
import 'package:qadr/features/quran/presentation/surah_reader_screen.dart';

import '../../helpers/golden_test_helpers.dart';

const _surahNumber = 2;

final _fakeSurah = Surah(
  number: _surahNumber,
  nameArabic: 'الْبَقَرَة',
  nameEnglish: 'The Cow',
  nameRussian: 'Корова',
  revelationType: 'Medinan',
  ayahCount: 286,
);

final _fakeAyahs = List.generate(
  5,
  (i) => Ayah(
    surahNumber: _surahNumber,
    ayahNumber: i + 1,
    textArabic: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
    textEnglish: 'In the name of Allah, the Most Gracious, the Most Merciful.',
    textRussian: 'Во имя Аллаха, Милостивого, Милосердного.',
  ),
);

void main() {
  goldenTest(
    'surah_reader_screen',
    providerOverrides: [
      surahProvider(_surahNumber).overrideWith((ref) async => _fakeSurah),
      ayahsProvider(_surahNumber).overrideWith((ref) async => _fakeAyahs),
    ],
    builder: (_) => const SurahReaderScreen(surahNumber: _surahNumber),
  );
}

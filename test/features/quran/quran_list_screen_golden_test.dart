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
    nameArabic: 'سورة',
    nameEnglish: 'Surah ${i + 1}',
    nameRussian: 'Сура ${i + 1}',
    revelationType: i.isEven ? 'Meccan' : 'Medinan',
    ayahCount: 7 + i * 3,
  ),
);

void main() {
  goldenTest(
    'quran_list_screen',
    providerOverrides: [
      surahListProvider.overrideWith((ref) async => _fakeSurahs),
    ],
    builder: (_) => QuranListScreen(onNavChanged: (_) {}),
  );
}

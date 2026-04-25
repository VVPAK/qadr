import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/app/theme.dart';
import 'package:qadr/core/data/database/app_database.dart';
import 'package:qadr/core/widgets/floating_nav_bar.dart';
import 'package:qadr/features/quran/presentation/providers/quran_providers.dart';
import 'package:qadr/features/quran/presentation/surah_reader_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';

const _surahNumber = 1;

final _fakeSurah = Surah(
  number: _surahNumber,
  nameArabic: 'الْفَاتِحَة',
  nameEnglish: 'The Opening',
  nameRussian: 'Открывающая',
  revelationType: 'Meccan',
  ayahCount: 7,
);

final _fakeAyahs = List.generate(
  3,
  (i) => Ayah(
    surahNumber: _surahNumber,
    ayahNumber: i + 1,
    textArabic: 'بِسْمِ ٱللَّهِ',
    textEnglish: 'In the name of Allah.',
    textRussian: 'Во имя Аллаха.',
  ),
);

void main() {
  testWidgets('SurahReaderScreen does not show FloatingNavBar', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          surahProvider(_surahNumber).overrideWith((ref) async => _fakeSurah),
          ayahsProvider(_surahNumber).overrideWith((ref) async => _fakeAyahs),
        ],
        child: MaterialApp(
          theme: QadrTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SurahReaderScreen(surahNumber: _surahNumber),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(FloatingNavBar), findsNothing);
  });
}

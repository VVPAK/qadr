import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/app/theme.dart';
import 'package:qadr/core/data/database/app_database.dart';
import 'package:qadr/features/quran/presentation/providers/quran_providers.dart';
import 'package:qadr/features/quran/presentation/quran_list_screen.dart';
import 'package:qadr/l10n/app_localizations.dart';

final _fakeSurahs = List.generate(
  5,
  (i) => Surah(
    number: i + 1,
    nameArabic: 'سورة ${i + 1}',
    nameEnglish: 'Surah ${i + 1}',
    nameRussian: 'Сура ${i + 1}',
    revelationType: 'Meccan',
    ayahCount: 7,
  ),
);

Ayah _fakeAyah(int surahNumber, int ayahNumber, String text) => Ayah(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      textArabic: 'عربي',
      textEnglish: text,
      textRussian: 'русский',
    );

final _fakeAyahs = [
  _fakeAyah(1, 1, 'In the name of Allah'),
  _fakeAyah(1, 2, 'All praise is due to Allah'),
];

Widget _buildApp({
  required List<Override> overrides,
  String locale = 'en',
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => QuranListScreen(onNavChanged: (_) {}),
      ),
      GoRoute(
        path: '/quran/:surahNumber',
        builder: (context, state) => const Scaffold(
          body: Text('Surah Reader'),
        ),
      ),
    ],
  );

  return ProviderScope(
    overrides: overrides,
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: Locale(locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: QadrTheme.light(),
      routerConfig: router,
    ),
  );
}

void main() {
  group('QuranListScreen search', () {
    testWidgets('initial state shows surah list, not search results',
        (tester) async {
      await tester.pumpWidget(_buildApp(
        overrides: [
          surahListProvider.overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchQueryProvider.overrideWith((_) => ''),
        ],
      ));
      await tester.pumpAndSettle();

      expect(find.text('Surah 1'), findsOneWidget);
      expect(find.text('Surah 5'), findsOneWidget);
    });

    testWidgets('entering text triggers search results after debounce',
        (tester) async {
      await tester.pumpWidget(_buildApp(
        overrides: [
          surahListProvider.overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchProvider('en').overrideWith(
            (_) async => QuranSearchResults(surahs: [], ayahs: _fakeAyahs),
          ),
        ],
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'al');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      expect(find.text('In the name of Allah'), findsOneWidget);
    });

    testWidgets('empty search results shows no-results text', (tester) async {
      await tester.pumpWidget(_buildApp(
        overrides: [
          surahListProvider.overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchProvider('en').overrideWith(
            (_) async =>
                const QuranSearchResults(surahs: [], ayahs: []),
          ),
        ],
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      expect(find.text('No results found'), findsOneWidget);
    });

    testWidgets('section headers appear when results exist', (tester) async {
      final surahResults = [_fakeSurahs.first];
      await tester.pumpWidget(_buildApp(
        overrides: [
          surahListProvider
              .overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchProvider('en').overrideWith(
            (_) async => QuranSearchResults(
                surahs: surahResults, ayahs: _fakeAyahs),
          ),
        ],
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'al');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      // Section headers are uppercase
      expect(find.text('SURAHS'), findsOneWidget);
      expect(find.text('VERSES'), findsOneWidget);
    });

    testWidgets('tapping ayah result navigates with ayah param',
        (tester) async {
      String? pushedRoute;
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                QuranListScreen(onNavChanged: (_) {}),
          ),
          GoRoute(
            path: '/quran/:surahNumber',
            builder: (context, state) {
              pushedRoute =
                  '/quran/${state.pathParameters['surahNumber']}?ayah=${state.uri.queryParameters['ayah']}';
              return const Scaffold(body: Text('Reader'));
            },
          ),
        ],
      );

      await tester.pumpWidget(ProviderScope(
        overrides: [
          surahListProvider.overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchProvider('en').overrideWith(
            (_) async =>
                QuranSearchResults(surahs: [], ayahs: [_fakeAyahs.first]),
          ),
        ],
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: QadrTheme.light(),
          routerConfig: router,
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'al');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      await tester.tap(find.text('In the name of Allah'));
      await tester.pumpAndSettle();

      expect(pushedRoute, '/quran/1?ayah=1');
    });

    testWidgets('clearing text restores surah list', (tester) async {
      await tester.pumpWidget(_buildApp(
        overrides: [
          surahListProvider.overrideWith((_) async => _fakeSurahs),
          quranInitProvider.overrideWith((_) async {}),
          quranSearchProvider('en').overrideWith(
            (_) async =>
                const QuranSearchResults(surahs: [], ayahs: []),
          ),
        ],
      ));
      await tester.pumpAndSettle();

      // Enter search
      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();
      expect(find.text('No results found'), findsOneWidget);

      // Tap clear button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      // Back to surah list
      expect(find.text('Surah 1'), findsOneWidget);
    });
  });
}

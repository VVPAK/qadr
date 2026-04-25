import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qadr/features/chat/domain/models/component_data.dart';
import 'package:qadr/features/quran/presentation/widgets/quran_ayah_card.dart';
import 'package:qadr/l10n/app_localizations.dart';

Widget _wrap(Widget child) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => Scaffold(body: child)),
      GoRoute(
        path: '/quran/:surahNumber',
        builder: (_, _) => const Scaffold(),
      ),
    ],
  );
  return MaterialApp.router(
    routerConfig: router,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}

const _data = QuranAyahData(
  ayahs: [
    AyahEntry(
      surah: 1,
      ayah: 1,
      arabic: 'بِسْمِ اللَّهِ',
      translation: 'In the name of Allah',
    ),
  ],
);

void main() {
  group('QuranAyahCard', () {
    testWidgets('renders surah:ayah reference', (tester) async {
      await tester.pumpWidget(_wrap(const QuranAyahCard(data: _data)));
      await tester.pumpAndSettle();
      expect(find.text('1:1'), findsOneWidget);
    });

    testWidgets('renders Arabic text', (tester) async {
      await tester.pumpWidget(_wrap(const QuranAyahCard(data: _data)));
      await tester.pumpAndSettle();
      expect(find.text('بِسْمِ اللَّهِ'), findsOneWidget);
    });

    testWidgets('renders translation', (tester) async {
      await tester.pumpWidget(_wrap(const QuranAyahCard(data: _data)));
      await tester.pumpAndSettle();
      expect(find.text('In the name of Allah'), findsOneWidget);
    });

    testWidgets('toContextJson includes type and ayahs', (tester) async {
      const card = QuranAyahCard(data: _data);
      final json = card.toContextJson();
      expect(json['type'], 'quranAyah');
      expect((json['ayahs'] as List), hasLength(1));
    });

    testWidgets('empty ayahs list renders nothing but is valid', (tester) async {
      const emptyCard = QuranAyahCard(data: QuranAyahData(ayahs: []));
      await tester.pumpWidget(_wrap(emptyCard));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/component_data.dart';
import 'package:qadr/features/chat/presentation/widgets/dua_chat_card.dart';
import 'package:qadr/l10n/app_localizations.dart';

Widget _wrap(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

const _dua = DuaData(
  arabic: 'رَبِّ زِدْنِي عِلْمًا',
  transliteration: 'Rabbi zidni ilma',
  translation: 'My Lord, increase me in knowledge.',
  source: 'Quran 20:114',
);

void main() {
  group('DuaChatCard', () {
    testWidgets('renders Arabic text', (tester) async {
      await tester.pumpWidget(_wrap(const DuaChatCard(data: _dua)));
      expect(find.text('رَبِّ زِدْنِي عِلْمًا'), findsOneWidget);
    });

    testWidgets('renders transliteration', (tester) async {
      await tester.pumpWidget(_wrap(const DuaChatCard(data: _dua)));
      expect(find.text('Rabbi zidni ilma'), findsOneWidget);
    });

    testWidgets('renders translation', (tester) async {
      await tester.pumpWidget(_wrap(const DuaChatCard(data: _dua)));
      expect(find.text('My Lord, increase me in knowledge.'), findsOneWidget);
    });

    testWidgets('renders source', (tester) async {
      await tester.pumpWidget(_wrap(const DuaChatCard(data: _dua)));
      expect(find.text('Quran 20:114'), findsOneWidget);
    });

    testWidgets('toContextJson includes type and arabic', (tester) async {
      const card = DuaChatCard(data: _dua);
      final json = card.toContextJson();
      expect(json['type'], 'dua');
      expect(json['arabic'], _dua.arabic);
    });
  });
}

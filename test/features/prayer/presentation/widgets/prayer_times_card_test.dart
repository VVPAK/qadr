import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/chat/domain/models/component_data.dart';
import 'package:qadr/features/prayer/presentation/widgets/prayer_times_card.dart';
import 'package:qadr/l10n/app_localizations.dart';

Widget _wrap(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

const _data = PrayerTimesData(
  prayers: [
    PrayerTimeEntry(name: 'fajr', time: '05:03', isNext: true),
    PrayerTimeEntry(name: 'dhuhr', time: '12:30'),
    PrayerTimeEntry(name: 'isha', time: '20:00'),
  ],
  date: '2026-04-24',
);

void main() {
  group('PrayerTimesCard', () {
    testWidgets('renders each prayer time', (tester) async {
      await tester.pumpWidget(_wrap(const PrayerTimesCard(data: _data)));
      await tester.pump();
      expect(find.text('05:03'), findsWidgets);
      expect(find.text('12:30'), findsWidgets);
      expect(find.text('20:00'), findsWidgets);
    });

    testWidgets('renders the date string', (tester) async {
      await tester.pumpWidget(_wrap(const PrayerTimesCard(data: _data)));
      await tester.pump();
      expect(find.text('2026-04-24'), findsOneWidget);
    });

    testWidgets('toContextJson includes type and prayer list', (tester) async {
      const card = PrayerTimesCard(data: _data);
      final json = card.toContextJson();
      expect(json['type'], 'prayerTimes');
      expect(json['date'], '2026-04-24');
    });
  });
}

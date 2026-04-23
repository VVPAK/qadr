import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:qadr/core/models/prayer_time_model.dart';
import 'package:qadr/core/services/widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WidgetService.findNextPrayer', () {
    late DateTime base;
    late PrayerTimeModel model;

    setUp(() {
      // Prayers at :01, :02, :03, :04, :05, :06 relative to base
      base = DateTime(2024, 1, 15, 10, 0);
      model = PrayerTimeModel(
        fajr: base.add(const Duration(hours: 1)),
        sunrise: base.add(const Duration(hours: 2)),
        dhuhr: base.add(const Duration(hours: 3)),
        asr: base.add(const Duration(hours: 4)),
        maghrib: base.add(const Duration(hours: 5)),
        isha: base.add(const Duration(hours: 6)),
        date: base,
      );
    });

    test('returns first prayer after now', () {
      final now = base.add(const Duration(hours: 2, minutes: 30));
      final (name, _) = WidgetService.findNextPrayer(model, now);
      expect(name, 'Dhuhr');
    });

    test('returns Fajr when now is before all prayers', () {
      final now = base.subtract(const Duration(minutes: 30));
      final (name, _) = WidgetService.findNextPrayer(model, now);
      expect(name, 'Fajr');
    });

    test('wraps to Fajr when all prayers have passed', () {
      final now = base.add(const Duration(hours: 7));
      final (name, _) = WidgetService.findNextPrayer(model, now);
      expect(name, 'Fajr');
    });

    test('returns Isha when between Maghrib and Isha', () {
      final now = base.add(const Duration(hours: 5, minutes: 30));
      final (name, _) = WidgetService.findNextPrayer(model, now);
      expect(name, 'Isha');
    });
  });

  group('WidgetService.update', () {
    late List<MethodCall> channelCalls;

    setUp(() {
      channelCalls = [];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('home_widget'),
        (call) async {
          channelCalls.add(call);
          return null;
        },
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('home_widget'),
        null,
      );
    });

    test('does nothing when location is not set', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = UserPreferences(await SharedPreferences.getInstance());
      final service = WidgetService(prefs);
      await service.update();
      expect(channelCalls, isEmpty);
    });

    test('writes prayer name, time, city and triggers widget update', () async {
      SharedPreferences.setMockInitialValues({
        'latitude': 55.79,
        'longitude': 49.12,
        'city_name': 'Kazan',
        'language': 'ru',
      });
      final prefs = UserPreferences(await SharedPreferences.getInstance());
      final service = WidgetService(prefs);
      await service.update();

      final savedKeys = channelCalls
          .where((c) => c.method == 'saveWidgetData')
          .map((c) => c.arguments['id'] as String)
          .toSet();

      expect(savedKeys, containsAll([
        'qadr_next_prayer_name',
        'qadr_next_prayer_time',
        'qadr_city_name',
        'qadr_language',
      ]));

      final nameCall = channelCalls.firstWhere(
        (c) => c.method == 'saveWidgetData' && c.arguments['id'] == 'qadr_next_prayer_name',
      );
      expect(
        ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'],
        contains(nameCall.arguments['data'] as String),
      );

      final updateCall = channelCalls.firstWhere(
        (c) => c.method == 'updateWidget',
        orElse: () => throw TestFailure('updateWidget was not called'),
      );
      expect(updateCall.arguments['ios'], 'QadrWidget');
    });

    test('saves city name from preferences', () async {
      SharedPreferences.setMockInitialValues({
        'latitude': 55.79,
        'longitude': 49.12,
        'city_name': 'Kazan',
        'language': 'ru',
      });
      final prefs = UserPreferences(await SharedPreferences.getInstance());
      final service = WidgetService(prefs);
      await service.update();

      final cityCall = channelCalls.firstWhere(
        (c) => c.method == 'saveWidgetData' && c.arguments['id'] == 'qadr_city_name',
      );
      expect(cityCall.arguments['data'], 'Kazan');
    });
  });
}

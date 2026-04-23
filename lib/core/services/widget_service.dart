import 'package:home_widget/home_widget.dart';

import '../data/preferences/user_preferences.dart';
import '../models/prayer_time_model.dart';
import '../../features/prayer/domain/prayer_times_service.dart';

class WidgetService {
  static const _appGroup = 'group.com.qadrapp';
  static const _keyPrayerName = 'qadr_next_prayer_name';
  static const _keyPrayerTime = 'qadr_next_prayer_time';
  static const _keyCityName = 'qadr_city_name';
  static const _keyLanguage = 'qadr_language';

  final UserPreferences _prefs;
  final PrayerTimesService _prayerService;

  WidgetService(this._prefs, [PrayerTimesService? prayerService])
      : _prayerService = prayerService ?? PrayerTimesService();

  static (String name, DateTime time) findNextPrayer(
    PrayerTimeModel model,
    DateTime now,
  ) {
    final prayers = [
      ('Fajr', model.fajr),
      ('Sunrise', model.sunrise),
      ('Dhuhr', model.dhuhr),
      ('Asr', model.asr),
      ('Maghrib', model.maghrib),
      ('Isha', model.isha),
    ];

    for (final (name, time) in prayers) {
      if (time.isAfter(now)) return (name, time);
    }
    // All prayers passed — wrap to Fajr
    return (prayers.first.$1, prayers.first.$2);
  }

  Future<void> update() async {
    final lat = _prefs.latitude;
    final lng = _prefs.longitude;
    if (lat == null || lng == null) return;

    await HomeWidget.setAppGroupId(_appGroup);

    final model = _prayerService.calculate(latitude: lat, longitude: lng);
    final (prayerName, prayerTime) = findNextPrayer(model, DateTime.now());

    await Future.wait([
      HomeWidget.saveWidgetData<String>(_keyPrayerName, prayerName),
      HomeWidget.saveWidgetData<String>(_keyPrayerTime, prayerTime.toIso8601String()),
      HomeWidget.saveWidgetData<String>(_keyCityName, _prefs.cityName ?? ''),
      HomeWidget.saveWidgetData<String>(_keyLanguage, _prefs.language),
    ]);

    await HomeWidget.updateWidget(iOSName: 'QadrWidget');
  }
}

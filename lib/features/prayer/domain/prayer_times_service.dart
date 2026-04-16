import 'package:adhan_dart/adhan_dart.dart' as adhan;

import '../../../core/constants/islamic_constants.dart';
import '../../../core/extensions/datetime_extensions.dart';
import '../../../core/models/prayer_time_model.dart';
import '../../chat/domain/models/component_data.dart';

class PrayerTimesService {
  PrayerTimeModel calculate({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) {
    final targetDate = date ?? DateTime.now();
    final coordinates = adhan.Coordinates(latitude, longitude);
    final params = _paramsForLocation(latitude, longitude);

    final prayerTimes = adhan.PrayerTimes(
      date: targetDate,
      coordinates: coordinates,
      calculationParameters: params,
    );

    return PrayerTimeModel(
      fajr: prayerTimes.fajr.toLocal(),
      sunrise: prayerTimes.sunrise.toLocal(),
      dhuhr: prayerTimes.dhuhr.toLocal(),
      asr: prayerTimes.asr.toLocal(),
      maghrib: prayerTimes.maghrib.toLocal(),
      isha: prayerTimes.isha.toLocal(),
      date: targetDate,
    );
  }

  PrayerTimesData toComponentData(PrayerTimeModel model) {
    final now = DateTime.now();
    final times = [
      (PrayerName.fajr, model.fajr),
      (PrayerName.sunrise, model.sunrise),
      (PrayerName.dhuhr, model.dhuhr),
      (PrayerName.asr, model.asr),
      (PrayerName.maghrib, model.maghrib),
      (PrayerName.isha, model.isha),
    ];

    PrayerName? nextPrayer;
    for (final (name, time) in times) {
      if (time.isAfter(now)) {
        nextPrayer = name;
        break;
      }
    }

    final prayers = times.map((entry) {
      final (name, time) = entry;
      return PrayerTimeEntry(
        name: name.name,
        time: time.timeString,
        isNext: name == nextPrayer,
      );
    }).toList();

    final dateStr = '${model.date.year}-'
        '${model.date.month.toString().padLeft(2, '0')}-'
        '${model.date.day.toString().padLeft(2, '0')}';

    return PrayerTimesData(prayers: prayers, date: dateStr);
  }

  /// Returns the predominant madhab for the given coordinates.
  static Madhab madhabForLocation(double lat, double lng) {
    // Hanafi regions: Turkey, Central Asia, South Asia, Russia
    if (lat >= 36 && lat <= 42 && lng >= 26 && lng <= 45) return Madhab.hanafi; // Turkey
    if (lat >= 23 && lat <= 38 && lng >= 60 && lng <= 78) return Madhab.hanafi; // Pakistan/Afghanistan
    if (lat >= 5 && lat <= 35 && lng >= 68 && lng <= 93) return Madhab.hanafi; // India/Bangladesh
    if (lat >= 35 && lat <= 55 && lng >= 50 && lng <= 88) return Madhab.hanafi; // Central Asia
    if (lat >= 42 && lat <= 70 && lng >= 26 && lng <= 60) return Madhab.hanafi; // Russia

    // Maliki regions: North/West Africa
    if (lat >= 27 && lat <= 36 && lng >= -13 && lng <= -1) return Madhab.maliki; // Morocco
    if (lat >= 18 && lat <= 38 && lng >= -1 && lng <= 25) return Madhab.maliki; // Algeria/Tunisia/Libya

    // Hanbali regions: Saudi Arabia
    if (lat >= 12 && lat <= 33 && lng >= 35 && lng <= 56) return Madhab.hanbali; // Arabian Peninsula

    // Shafi'i regions: Southeast Asia, East Africa
    if (lat >= -11 && lat <= 20 && lng >= 93 && lng <= 141) return Madhab.shafii; // SE Asia

    // Default
    return Madhab.shafii;
  }

  /// Determines the calculation method and madhab based on coordinates.
  ///
  /// Maps geographic regions to the prayer calculation authority used locally:
  /// - Turkey → Diyanet (Hanafi)
  /// - Saudi Arabia → Umm al-Qura
  /// - UAE/Oman → Dubai
  /// - Qatar → Qatar
  /// - Kuwait → Kuwait
  /// - Egypt → Egyptian General Authority
  /// - Iran → Tehran
  /// - Morocco → Morocco
  /// - Pakistan/Afghanistan → Karachi (Hanafi)
  /// - South Asia (India, Bangladesh, Sri Lanka) → Karachi (Hanafi)
  /// - Central Asia → Muslim World League (Hanafi)
  /// - Southeast Asia → Singapore (Shafi'i)
  /// - North America → ISNA
  /// - Default → Muslim World League (Shafi'i)
  adhan.CalculationParameters _paramsForLocation(double lat, double lng) {
    // Turkey
    if (lat >= 36 && lat <= 42 && lng >= 26 && lng <= 45) {
      return adhan.CalculationMethodParameters.turkiye();
    }

    // Iran
    if (lat >= 25 && lat <= 40 && lng >= 44 && lng <= 63) {
      return adhan.CalculationMethodParameters.tehran();
    }

    // Kuwait (check before Saudi — overlapping lng range)
    if (lat >= 28.5 && lat <= 30.5 && lng >= 46.5 && lng <= 48.5) {
      return adhan.CalculationMethodParameters.kuwait();
    }

    // Qatar
    if (lat >= 24.4 && lat <= 26.2 && lng >= 50.5 && lng <= 51.7) {
      return adhan.CalculationMethodParameters.qatar();
    }

    // UAE / Oman
    if (lat >= 22 && lat <= 26.5 && lng >= 51 && lng <= 60) {
      return adhan.CalculationMethodParameters.dubai();
    }

    // Saudi Arabia / Yemen / Jordan / Iraq
    if (lat >= 12 && lat <= 33 && lng >= 35 && lng <= 56) {
      return adhan.CalculationMethodParameters.ummAlQura();
    }

    // Egypt
    if (lat >= 22 && lat <= 32 && lng >= 25 && lng <= 35) {
      return adhan.CalculationMethodParameters.egyptian();
    }

    // Morocco
    if (lat >= 27 && lat <= 36 && lng >= -13 && lng <= -1) {
      return adhan.CalculationMethodParameters.morocco();
    }

    // North Africa (Algeria, Tunisia, Libya)
    if (lat >= 18 && lat <= 38 && lng >= -1 && lng <= 25) {
      return adhan.CalculationMethodParameters.egyptian();
    }

    // Pakistan / Afghanistan
    if (lat >= 23 && lat <= 38 && lng >= 60 && lng <= 78) {
      final params = adhan.CalculationMethodParameters.karachi();
      params.madhab = adhan.Madhab.hanafi;
      return params;
    }

    // India / Bangladesh / Sri Lanka
    if (lat >= 5 && lat <= 35 && lng >= 68 && lng <= 93) {
      final params = adhan.CalculationMethodParameters.karachi();
      params.madhab = adhan.Madhab.hanafi;
      return params;
    }

    // Central Asia (Kazakhstan, Uzbekistan, Kyrgyzstan, etc.)
    if (lat >= 35 && lat <= 55 && lng >= 50 && lng <= 88) {
      final params = adhan.CalculationMethodParameters.muslimWorldLeague();
      params.madhab = adhan.Madhab.hanafi;
      return params;
    }

    // Southeast Asia (Indonesia, Malaysia, Brunei, etc.)
    if (lat >= -11 && lat <= 20 && lng >= 93 && lng <= 141) {
      return adhan.CalculationMethodParameters.singapore();
    }

    // North America
    if (lat >= 15 && lat <= 72 && lng >= -170 && lng <= -50) {
      return adhan.CalculationMethodParameters.northAmerica();
    }

    // Russia (European part — mostly Hanafi Muslim population)
    if (lat >= 42 && lat <= 70 && lng >= 26 && lng <= 60) {
      final params = adhan.CalculationMethodParameters.muslimWorldLeague();
      params.madhab = adhan.Madhab.hanafi;
      return params;
    }

    // Default: Muslim World League, Shafi'i
    return adhan.CalculationMethodParameters.muslimWorldLeague();
  }
}

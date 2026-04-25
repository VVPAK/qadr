import '../../../core/models/prayer_time_model.dart';
import '../../../core/models/result.dart';
import '../domain/prayer_times_repository.dart';
import '../domain/prayer_times_service.dart';
import 'aladhan_api_service.dart';
import 'aladhan_timings.dart';

class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  PrayerTimesRepositoryImpl({
    required AladhanApiService apiService,
    required PrayerTimesService fallback,
  }) : _api = apiService,
       _fallback = fallback;

  final AladhanApiService _api;
  final PrayerTimesService _fallback;

  @override
  Future<Result<PrayerTimeModel>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    try {
      final timings = await _api.getTimings(
        latitude: latitude,
        longitude: longitude,
        date: date,
      );
      return Success(_timingsToModel(timings, date));
    } catch (_) {
      try {
        final model = _fallback.calculate(
          latitude: latitude,
          longitude: longitude,
          date: date,
        );
        return Success(model);
      } catch (e) {
        return Failure('Failed to get prayer times', error: e);
      }
    }
  }

  PrayerTimeModel _timingsToModel(AladhanTimings timings, DateTime date) {
    DateTime parse(String hhmm) {
      final parts = hhmm.split(':');
      return DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    return PrayerTimeModel(
      fajr: parse(timings.fajr),
      sunrise: parse(timings.sunrise),
      dhuhr: parse(timings.dhuhr),
      asr: parse(timings.asr),
      maghrib: parse(timings.maghrib),
      isha: parse(timings.isha),
      date: date,
    );
  }
}

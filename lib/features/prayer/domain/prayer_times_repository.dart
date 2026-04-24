import '../../../core/models/prayer_time_model.dart';
import '../../../core/models/result.dart';

abstract class PrayerTimesRepository {
  Future<Result<PrayerTimeModel>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  });
}

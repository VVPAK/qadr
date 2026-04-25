import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/models/prayer_time_model.dart';
import 'package:qadr/core/models/result.dart';
import 'package:qadr/features/prayer/data/aladhan_api_service.dart';
import 'package:qadr/features/prayer/data/aladhan_timings.dart';
import 'package:qadr/features/prayer/data/prayer_times_repository_impl.dart';
import 'package:qadr/features/prayer/domain/prayer_times_service.dart';

class _FakeApiService extends AladhanApiService {
  final AladhanTimings? response;
  final Exception? error;

  _FakeApiService({this.response, this.error});

  @override
  Future<AladhanTimings> getTimings({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    if (error != null) throw error!;
    return response!;
  }
}

void main() {
  const dubaiLat = 25.2048;
  const dubaiLng = 55.2708;
  final date = DateTime(2026, 4, 24);

  final dubaiTimings = AladhanTimings(
    fajr: '04:27',
    sunrise: '05:45',
    dhuhr: '12:19',
    asr: '15:48',
    maghrib: '18:49',
    isha: '20:05',
  );

  group('PrayerTimesRepositoryImpl', () {
    test('returns Success with API times when network succeeds', () async {
      final repo = PrayerTimesRepositoryImpl(
        apiService: _FakeApiService(response: dubaiTimings),
        fallback: PrayerTimesService(),
      );

      final result = await repo.getPrayerTimes(
        latitude: dubaiLat,
        longitude: dubaiLng,
        date: date,
      );

      expect(result, isA<Success<PrayerTimeModel>>());
      final model = (result as Success<PrayerTimeModel>).data;
      expect(model.fajr, DateTime(2026, 4, 24, 4, 27));
      expect(model.sunrise, DateTime(2026, 4, 24, 5, 45));
      expect(model.dhuhr, DateTime(2026, 4, 24, 12, 19));
      expect(model.asr, DateTime(2026, 4, 24, 15, 48));
      expect(model.maghrib, DateTime(2026, 4, 24, 18, 49));
      expect(model.isha, DateTime(2026, 4, 24, 20, 5));
    });

    test('falls back to local calculation when network throws', () async {
      final repo = PrayerTimesRepositoryImpl(
        apiService: _FakeApiService(error: Exception('no network')),
        fallback: PrayerTimesService(),
      );

      final result = await repo.getPrayerTimes(
        latitude: dubaiLat,
        longitude: dubaiLng,
        date: date,
      );

      expect(result, isA<Success<PrayerTimeModel>>());
      final model = (result as Success<PrayerTimeModel>).data;
      // Fallback times are calculated — just verify ordering is preserved.
      expect(model.fajr.isBefore(model.sunrise), isTrue);
      expect(model.sunrise.isBefore(model.dhuhr), isTrue);
      expect(model.dhuhr.isBefore(model.asr), isTrue);
      expect(model.asr.isBefore(model.maghrib), isTrue);
      expect(model.maghrib.isBefore(model.isha), isTrue);
    });

    test('stores the requested date in the returned model', () async {
      final repo = PrayerTimesRepositoryImpl(
        apiService: _FakeApiService(response: dubaiTimings),
        fallback: PrayerTimesService(),
      );

      final result = await repo.getPrayerTimes(
        latitude: dubaiLat,
        longitude: dubaiLng,
        date: date,
      );

      final model = (result as Success<PrayerTimeModel>).data;
      expect(model.date, date);
    });

    test('API times take priority over fallback when both available', () async {
      // We can verify this by checking that returned Fajr matches API, not adhan_dart.
      // Dubai adhan_dart fajr would be different from "04:27" from our fake API.
      final repo = PrayerTimesRepositoryImpl(
        apiService: _FakeApiService(response: dubaiTimings),
        fallback: PrayerTimesService(),
      );

      final result = await repo.getPrayerTimes(
        latitude: dubaiLat,
        longitude: dubaiLng,
        date: date,
      );

      final model = (result as Success<PrayerTimeModel>).data;
      // API returns 04:27 — this is our fake's exact value.
      expect(model.fajr.hour, 4);
      expect(model.fajr.minute, 27);
    });
  });
}

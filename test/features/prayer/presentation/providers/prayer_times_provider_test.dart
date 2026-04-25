import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/models/prayer_time_model.dart';
import 'package:qadr/core/models/result.dart';
import 'package:qadr/features/prayer/data/prayer_times_repository_impl.dart';
import 'package:qadr/features/prayer/domain/prayer_times_repository.dart';
import 'package:qadr/features/prayer/domain/prayer_times_service.dart';
import 'package:qadr/features/prayer/presentation/providers/prayer_times_provider.dart';

class _FakeRepo implements PrayerTimesRepository {
  final PrayerTimeModel model;
  _FakeRepo(this.model);

  @override
  Future<Result<PrayerTimeModel>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    return Success(model);
  }
}

PrayerTimeModel _model(DateTime date) => PrayerTimeModel(
  date: date,
  fajr: DateTime(date.year, date.month, date.day, 5, 0),
  sunrise: DateTime(date.year, date.month, date.day, 6, 30),
  dhuhr: DateTime(date.year, date.month, date.day, 12, 0),
  asr: DateTime(date.year, date.month, date.day, 15, 30),
  maghrib: DateTime(date.year, date.month, date.day, 18, 30),
  isha: DateTime(date.year, date.month, date.day, 20, 0),
);

void main() {
  group('prayerTimesForDayProvider', () {
    test('resolves to PrayerTimeModel from repository', () async {
      final date = DateTime(2026, 4, 24);
      final model = _model(date);
      final container = ProviderContainer(
        overrides: [
          prayerTimesRepositoryProvider.overrideWithValue(_FakeRepo(model)),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(
        prayerTimesForDayProvider(
          (lat: 21.4, lng: 39.8, dateKey: '2026-4-24'),
        ).future,
      );

      expect(result.fajr.hour, 5);
      expect(result.dhuhr.hour, 12);
    });

    test('parses dateKey into correct DateTime for the repository', () async {
      final date = DateTime(2026, 1, 5);
      final model = _model(date);
      DateTime? capturedDate;

      final repo = _CapturingRepo(model, onGet: (d) => capturedDate = d);
      final container = ProviderContainer(
        overrides: [
          prayerTimesRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(
        prayerTimesForDayProvider(
          (lat: 0, lng: 0, dateKey: '2026-1-5'),
        ).future,
      );

      expect(capturedDate?.year, 2026);
      expect(capturedDate?.month, 1);
      expect(capturedDate?.day, 5);
    });

    test('throws when repository returns Failure', () async {
      final container = ProviderContainer(
        overrides: [
          prayerTimesRepositoryProvider.overrideWithValue(_FailingRepo()),
        ],
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(
          prayerTimesForDayProvider(
            (lat: 0, lng: 0, dateKey: '2026-4-24'),
          ).future,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('prayerTimesServiceProvider creates a PrayerTimesService', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(container.read(prayerTimesServiceProvider), isA<PrayerTimesService>());
    });

    test('prayerTimesRepositoryProvider creates a PrayerTimesRepositoryImpl', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(
        container.read(prayerTimesRepositoryProvider),
        isA<PrayerTimesRepositoryImpl>(),
      );
    });
  });
}

class _CapturingRepo implements PrayerTimesRepository {
  final PrayerTimeModel model;
  final void Function(DateTime date) onGet;
  _CapturingRepo(this.model, {required this.onGet});

  @override
  Future<Result<PrayerTimeModel>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    onGet(date);
    return Success(model);
  }
}

class _FailingRepo implements PrayerTimesRepository {
  @override
  Future<Result<PrayerTimeModel>> getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    return const Failure('network error');
  }
}

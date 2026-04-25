import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/prayer_time_model.dart';
import '../../../../core/models/result.dart';
import '../../data/aladhan_api_service.dart';
import '../../data/prayer_times_repository_impl.dart';
import '../../domain/prayer_times_repository.dart';
import '../../domain/prayer_times_service.dart';

final prayerTimesServiceProvider = Provider<PrayerTimesService>((ref) {
  return PrayerTimesService();
});

final prayerTimesRepositoryProvider = Provider<PrayerTimesRepository>((ref) {
  return PrayerTimesRepositoryImpl(
    apiService: AladhanApiService(),
    fallback: ref.read(prayerTimesServiceProvider),
  );
});

/// Cached prayer times for a given location + calendar day.
///
/// Not autoDispose — Riverpod keeps the result alive for the app session so
/// revisiting the prayer screen within the same day is instant with no jump.
/// The family key changes at midnight, which naturally triggers a fresh fetch.
final prayerTimesForDayProvider = FutureProvider.family<PrayerTimeModel,
    ({double lat, double lng, String dateKey})>((ref, args) async {
  final parts = args.dateKey.split('-');
  final date =
      DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  final result = await ref.read(prayerTimesRepositoryProvider).getPrayerTimes(
        latitude: args.lat,
        longitude: args.lng,
        date: date,
      );
  return switch (result) {
    Success(:final data) => data,
    Failure(:final message, :final error) =>
      throw Exception('$message${error != null ? ': $error' : ''}'),
  };
});

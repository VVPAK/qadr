import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/prayer_times_service.dart';

final prayerTimesServiceProvider = Provider<PrayerTimesService>((ref) {
  return PrayerTimesService();
});

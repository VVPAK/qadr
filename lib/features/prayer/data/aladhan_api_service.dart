import 'package:dio/dio.dart';

import 'aladhan_timings.dart';

class AladhanApiService {
  AladhanApiService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  static const _baseUrl = 'https://api.aladhan.com/v1';

  Future<AladhanTimings> getTimings({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) async {
    final method = methodForLocation(latitude, longitude);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final dateStr = '$day-$month-${date.year}';

    final response = await _dio.get<Map<String, dynamic>>(
      '$_baseUrl/timings/$dateStr',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'method': method,
      },
    );

    final body = response.data;
    if (body == null || body['code'] != 200) {
      throw Exception('Al Adhan API error: ${body?['status']}');
    }

    final timings =
        (body['data'] as Map<String, dynamic>)['timings']
            as Map<String, dynamic>;
    return AladhanTimings.fromJson(timings);
  }

  /// Maps geographic coordinates to the Al Adhan API method ID used locally.
  ///
  /// Method IDs: 1=Karachi, 2=ISNA, 3=MWL, 4=Umm Al-Qura, 5=Egyptian,
  /// 7=Tehran, 8=Gulf, 9=Kuwait, 10=Qatar, 11=Singapore, 13=Diyanet, 21=Morocco.
  static int methodForLocation(double lat, double lng) {
    // Turkey → Diyanet (13)
    if (lat >= 36 && lat <= 42 && lng >= 26 && lng <= 45) return 13;
    // Kuwait (9) — before Iran to avoid overlap with Iran's lng range
    if (lat >= 28.5 && lat <= 30.5 && lng >= 46.5 && lng <= 48.5) return 9;
    // Qatar (10) — before Iran
    if (lat >= 24.4 && lat <= 26.2 && lng >= 50.5 && lng <= 51.7) return 10;
    // UAE / Oman → Gulf (8) — before Iran
    if (lat >= 22 && lat <= 26.5 && lng >= 51 && lng <= 60) return 8;
    // Iran → Tehran (7)
    if (lat >= 25 && lat <= 40 && lng >= 44 && lng <= 63) return 7;
    // Saudi Arabia / Yemen / Jordan / Iraq → Umm Al-Qura (4)
    if (lat >= 12 && lat <= 33 && lng >= 35 && lng <= 56) return 4;
    // Egypt (5)
    if (lat >= 22 && lat <= 32 && lng >= 25 && lng <= 35) return 5;
    // Morocco (21)
    if (lat >= 27 && lat <= 36 && lng >= -13 && lng <= -1) return 21;
    // North Africa (5)
    if (lat >= 18 && lat <= 38 && lng >= -1 && lng <= 25) return 5;
    // Pakistan / Afghanistan → Karachi (1)
    if (lat >= 23 && lat <= 38 && lng >= 60 && lng <= 78) return 1;
    // India / Bangladesh / Sri Lanka → Karachi (1)
    if (lat >= 5 && lat <= 35 && lng >= 68 && lng <= 93) return 1;
    // Central Asia → MWL (3)
    if (lat >= 35 && lat <= 55 && lng >= 50 && lng <= 88) return 3;
    // Southeast Asia → Singapore (11)
    if (lat >= -11 && lat <= 20 && lng >= 93 && lng <= 141) return 11;
    // North America → ISNA (2)
    if (lat >= 15 && lat <= 72 && lng >= -170 && lng <= -50) return 2;
    // Russia → MWL (3)
    if (lat >= 42 && lat <= 70 && lng >= 26 && lng <= 60) return 3;
    // Default → MWL (3)
    return 3;
  }
}

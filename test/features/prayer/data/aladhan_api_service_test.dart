import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/prayer/data/aladhan_api_service.dart';

class _FakeAdapter implements HttpClientAdapter {
  final String body;
  final int statusCode;

  _FakeAdapter({required this.body, this.statusCode = 200});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _dubaiTimings = {
  'Fajr': '04:27',
  'Sunrise': '05:45',
  'Dhuhr': '12:19',
  'Asr': '15:48',
  'Sunset': '18:49',
  'Maghrib': '18:49',
  'Isha': '20:05',
  'Imsak': '04:17',
  'Midnight': '00:19',
};

String _buildResponse(Map<String, String> timings) => jsonEncode({
  'code': 200,
  'status': 'OK',
  'data': {
    'timings': timings,
    'date': {'readable': '24 Apr 2026', 'timestamp': '1745443261'},
    'meta': {
      'latitude': 25.2048,
      'longitude': 55.2708,
      'timezone': 'Asia/Dubai',
      'method': {'id': 8, 'name': 'Gulf Region'},
    },
  },
});

void main() {
  group('AladhanApiService.methodForLocation', () {
    test('returns 8 (Gulf) for Dubai', () {
      expect(AladhanApiService.methodForLocation(25.2, 55.3), 8);
    });

    test('returns 8 (Gulf) for Abu Dhabi', () {
      expect(AladhanApiService.methodForLocation(24.5, 54.4), 8);
    });

    test('returns 13 (Diyanet) for Istanbul', () {
      expect(AladhanApiService.methodForLocation(41.01, 28.97), 13);
    });

    test('returns 7 (Tehran) for Tehran', () {
      expect(AladhanApiService.methodForLocation(35.7, 51.4), 7);
    });

    test('returns 9 (Kuwait) for Kuwait City', () {
      expect(AladhanApiService.methodForLocation(29.4, 47.9), 9);
    });

    test('returns 10 (Qatar) for Doha', () {
      expect(AladhanApiService.methodForLocation(25.3, 51.5), 10);
    });

    test('returns 4 (Umm Al-Qura) for Mecca', () {
      expect(AladhanApiService.methodForLocation(21.42, 39.83), 4);
    });

    test('returns 5 (Egyptian) for Cairo', () {
      expect(AladhanApiService.methodForLocation(30.07, 31.23), 5);
    });

    test('returns 21 (Morocco) for Casablanca', () {
      expect(AladhanApiService.methodForLocation(33.57, -7.58), 21);
    });

    test('returns 1 (Karachi) for Lahore', () {
      expect(AladhanApiService.methodForLocation(31.5, 74.3), 1);
    });

    test('returns 1 (Karachi) for Mumbai', () {
      expect(AladhanApiService.methodForLocation(19.08, 72.88), 1);
    });

    test('returns 11 (Singapore) for Jakarta', () {
      expect(AladhanApiService.methodForLocation(-6.2, 106.8), 11);
    });

    test('returns 2 (ISNA) for New York', () {
      expect(AladhanApiService.methodForLocation(40.7, -74.0), 2);
    });

    test('returns 3 (MWL) for Almaty (Central Asia)', () {
      expect(AladhanApiService.methodForLocation(43.2, 76.9), 3);
    });

    test('returns 3 (MWL) for unmapped region', () {
      expect(AladhanApiService.methodForLocation(0.0, 0.0), 3);
    });
  });

  group('AladhanApiService.getTimings', () {
    Dio fakeDio(String body, {int statusCode = 200}) {
      final dio = Dio();
      dio.httpClientAdapter = _FakeAdapter(body: body, statusCode: statusCode);
      return dio;
    }

    test('parses Dubai API response correctly', () async {
      final service = AladhanApiService(
        dio: fakeDio(_buildResponse(_dubaiTimings)),
      );

      final timings = await service.getTimings(
        latitude: 25.2048,
        longitude: 55.2708,
        date: DateTime(2026, 4, 24),
      );

      expect(timings.fajr, '04:27');
      expect(timings.sunrise, '05:45');
      expect(timings.dhuhr, '12:19');
      expect(timings.asr, '15:48');
      expect(timings.maghrib, '18:49');
      expect(timings.isha, '20:05');
    });

    test('strips timezone suffix from time strings', () async {
      final timingsWithSuffix = {
        ..._dubaiTimings,
        'Fajr': '04:27 (+04)',
        'Isha': '20:05 (+04)',
      };
      final service = AladhanApiService(
        dio: fakeDio(_buildResponse(timingsWithSuffix)),
      );

      final timings = await service.getTimings(
        latitude: 25.2048,
        longitude: 55.2708,
        date: DateTime(2026, 4, 24),
      );

      expect(timings.fajr, '04:27');
      expect(timings.isha, '20:05');
    });

    test('throws when API returns error code in body', () async {
      final errorBody = jsonEncode({
        'code': 400,
        'status': 'Bad Request',
        'data': 'Invalid latitude or longitude.',
      });
      final service = AladhanApiService(dio: fakeDio(errorBody));

      await expectLater(
        service.getTimings(
          latitude: 999.0,
          longitude: 999.0,
          date: DateTime(2026, 4, 24),
        ),
        throwsException,
      );
    });

    test(
      'sends correct date format (DD-MM-YYYY) and method in query',
      () async {
        RequestOptions? captured;
        final dio = Dio();
        dio.httpClientAdapter = _FakeAdapter(
          body: _buildResponse(_dubaiTimings),
        );
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              captured = options;
              handler.next(options);
            },
          ),
        );

        final service = AladhanApiService(dio: dio);
        await service.getTimings(
          latitude: 25.2048,
          longitude: 55.2708,
          date: DateTime(2026, 4, 5), // day < 10 to test zero-padding
        );

        expect(captured, isNotNull);
        expect(captured!.uri.path, contains('05-04-2026'));
        expect(captured!.queryParameters['method'], 8); // Gulf for Dubai
      },
    );
  });
}

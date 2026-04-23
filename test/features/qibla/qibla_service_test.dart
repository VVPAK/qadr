import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/features/qibla/domain/qibla_service.dart';

void main() {
  const service = QiblaService();

  group('QiblaService.calculateBearing', () {
    test('bearing is always in [0, 360)', () {
      for (final lat in [-80.0, -30.0, 0.0, 30.0, 60.0]) {
        for (final lng in [-170.0, -90.0, 0.0, 90.0, 170.0]) {
          final b = service.calculateBearing(lat, lng);
          expect(b, greaterThanOrEqualTo(0));
          expect(b, lessThan(360));
        }
      }
    });

    test('bearing from Kaaba itself is well-defined (no NaN/infinite)', () {
      final b = service.calculateBearing(21.4225, 39.8262);
      expect(b.isNaN, isFalse);
      expect(b.isFinite, isTrue);
    });

    test('London → south-east (expected ~119°)', () {
      // Reference: great-circle bearing from London to Mecca is ~118–119°.
      final b = service.calculateBearing(51.5074, -0.1278);
      expect(b, closeTo(119, 2));
    });

    test('New York → north-east (expected ~58°)', () {
      final b = service.calculateBearing(40.7128, -74.0060);
      expect(b, closeTo(58, 3));
    });

    test('Tashkent → south-west (expected ~243°)', () {
      final b = service.calculateBearing(41.3111, 69.2406);
      expect(b, closeTo(243, 3));
    });

    test('Jakarta → west-north-west (expected ~295°)', () {
      final b = service.calculateBearing(-6.2088, 106.8456);
      expect(b, closeTo(295, 3));
    });

    test('Cape Town → north-north-east (expected ~23°)', () {
      final b = service.calculateBearing(-33.9249, 18.4241);
      expect(b, closeTo(23, 3));
    });

    test('locations at the same longitude as Mecca head due north/south', () {
      // Due north from Mecca.
      final northB = service.calculateBearing(50.0, 39.8262);
      expect(northB, closeTo(180, 1));
      // Due south from Mecca.
      final southB = service.calculateBearing(-20.0, 39.8262);
      expect(southB, closeTo(0, 1));
    });
  });

  group('QiblaService.calculateDeclination', () {
    test('stays finite across the globe', () {
      for (final lat in [-85.0, -30.0, 0.0, 30.0, 85.0]) {
        for (final lng in [-170.0, 0.0, 170.0]) {
          final d = service.calculateDeclination(lat, lng);
          expect(d.isFinite, isTrue,
              reason: 'lat=$lat lng=$lng produced $d');
        }
      }
    });

    test('is in the ±180° range', () {
      for (final lat in [-60.0, 0.0, 60.0]) {
        for (final lng in [-170.0, -90.0, 0.0, 90.0, 170.0]) {
          final d = service.calculateDeclination(lat, lng);
          expect(d, inInclusiveRange(-180, 180));
        }
      }
    });

    test('London declination is small (single digits, east-positive)', () {
      // Dipole approximation near the UK sits in the ~-5..+5° range.
      final d = service.calculateDeclination(51.5074, -0.1278);
      expect(d.abs(), lessThan(15));
    });

    test('North American east coast declination stays within dipole range',
        () {
      // The simple dipole approximation can't capture regional distortion
      // (WMM puts NY at ~-13°) but must stay within a ~±15° envelope.
      final d = service.calculateDeclination(40.7128, -74.0060);
      expect(d.abs(), lessThan(15));
    });
  });

  group('QiblaReading.magneticBearing', () {
    test('subtracts declination and wraps into [0, 360)', () {
      const r = QiblaReading(bearing: 119.0, declination: 5.0);
      expect(r.magneticBearing, closeTo(114.0, 0.0001));
    });

    test('wraps negative results around 360', () {
      const r = QiblaReading(bearing: 10.0, declination: 30.0);
      expect(r.magneticBearing, closeTo(340.0, 0.0001));
    });

    test('handles eastern declination by subtracting (bearing shifts west)',
        () {
      const r = QiblaReading(bearing: 90.0, declination: 10.0);
      expect(r.magneticBearing, closeTo(80.0, 0.0001));
    });

    test('handles western (negative) declination by adding', () {
      const r = QiblaReading(bearing: 90.0, declination: -10.0);
      expect(r.magneticBearing, closeTo(100.0, 0.0001));
    });

    test('result is always in [0, 360)', () {
      for (final bearing in [0.0, 90.0, 180.0, 270.0, 359.9]) {
        for (final decl in [-45.0, -10.0, 0.0, 10.0, 45.0]) {
          final r = QiblaReading(bearing: bearing, declination: decl);
          expect(r.magneticBearing, greaterThanOrEqualTo(0));
          expect(r.magneticBearing, lessThan(360));
        }
      }
    });
  });
}

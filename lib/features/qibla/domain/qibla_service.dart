import 'dart:math' as math;

import '../../../core/constants/app_constants.dart';

class QiblaReading {
  const QiblaReading({required this.bearing, required this.declination});

  // Bearing from true north (degrees clockwise, 0–360).
  final double bearing;

  // Magnetic declination in degrees, east-positive.
  final double declination;

  // Bearing from magnetic north. Subtracting a device's magnetic heading
  // from this gives the needle angle for on-screen rotation.
  double get magneticBearing => (bearing - declination + 360) % 360;
}

class QiblaService {
  const QiblaService();

  double calculateBearing(double lat, double lng) {
    const kaabaLat = AppConstants.kaabaLatitude * math.pi / 180;
    const kaabaLng = AppConstants.kaabaLongitude * math.pi / 180;
    final userLat = lat * math.pi / 180;
    final userLng = lng * math.pi / 180;
    final dLng = kaabaLng - userLng;
    final y = math.sin(dLng);
    final x = math.cos(userLat) * math.tan(kaabaLat) -
        math.sin(userLat) * math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  // Dipole approximation of magnetic declination. Accurate to ~5-10°
  // worldwide. Good enough for qibla within the ±3° alignment window in
  // most regions, but not IGRF/WMM quality. Pure Dart — no plugin needed.
  // Pole position is the IGRF-13 geomagnetic (not magnetic) north pole for
  // epoch 2025, which gives smoother behavior than the drifting dip pole.
  double calculateDeclination(double lat, double lng) {
    const poleLat = 80.7 * math.pi / 180;
    const poleLng = -72.7 * math.pi / 180;
    final userLat = lat * math.pi / 180;
    final userLng = lng * math.pi / 180;
    final dLng = poleLng - userLng;
    final y = math.sin(dLng) * math.cos(poleLat);
    final x = math.cos(userLat) * math.sin(poleLat) -
        math.sin(userLat) * math.cos(poleLat) * math.cos(dLng);
    return math.atan2(y, x) * 180 / math.pi;
  }
}

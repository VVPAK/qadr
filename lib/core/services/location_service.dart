import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/prayer/domain/prayer_times_service.dart';
import '../data/preferences/user_preferences.dart';

class LocationService {
  const LocationService();

  Future<bool> requestAndFetchPosition(UserPreferences prefs) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return false;
    }

    final position = await Geolocator.getCurrentPosition();
    prefs.latitude = position.latitude;
    prefs.longitude = position.longitude;
    prefs.madhab = PrayerTimesService.madhabForLocation(
      position.latitude,
      position.longitude,
    );

    unawaited(resolveCityName(position.latitude, position.longitude, prefs));
    return true;
  }

  Future<String?> resolveCityName(
    double lat,
    double lng,
    UserPreferences prefs,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return null;
      final p = placemarks.first;
      final city = p.locality?.isNotEmpty == true
          ? p.locality
          : p.subAdministrativeArea?.isNotEmpty == true
              ? p.subAdministrativeArea
              : p.administrativeArea;
      if (city != null && city.isNotEmpty) {
        prefs.cityName = city;
        return city;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

final locationServiceProvider =
    Provider<LocationService>((_) => const LocationService());

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/islamic_constants.dart';

class UserPreferences {
  UserPreferences(this._prefs);
  final SharedPreferences _prefs;

  static const _keyOnboardingComplete = 'onboarding_complete';
  static const _keyMadhab = 'madhab';
  static const _keyLanguage = 'language';
  static const _keyName = 'name';
  static const _keyLatitude = 'latitude';
  static const _keyLongitude = 'longitude';
  static const _keyNotificationsEnabled = 'notifications_enabled';

  bool get onboardingComplete => _prefs.getBool(_keyOnboardingComplete) ?? false;
  set onboardingComplete(bool value) => _prefs.setBool(_keyOnboardingComplete, value);

  Madhab get madhab {
    final index = _prefs.getInt(_keyMadhab) ?? 0;
    return Madhab.values[index];
  }
  set madhab(Madhab value) => _prefs.setInt(_keyMadhab, value.index);

  String get language => _prefs.getString(_keyLanguage) ?? 'en';
  set language(String value) => _prefs.setString(_keyLanguage, value);

  String? get name => _prefs.getString(_keyName);
  set name(String? value) {
    if (value != null) {
      _prefs.setString(_keyName, value);
    } else {
      _prefs.remove(_keyName);
    }
  }

  double? get latitude => _prefs.getDouble(_keyLatitude);
  set latitude(double? value) {
    if (value != null) {
      _prefs.setDouble(_keyLatitude, value);
    } else {
      _prefs.remove(_keyLatitude);
    }
  }

  double? get longitude => _prefs.getDouble(_keyLongitude);
  set longitude(double? value) {
    if (value != null) {
      _prefs.setDouble(_keyLongitude, value);
    } else {
      _prefs.remove(_keyLongitude);
    }
  }

  bool get notificationsEnabled => _prefs.getBool(_keyNotificationsEnabled) ?? true;
  set notificationsEnabled(bool value) => _prefs.setBool(_keyNotificationsEnabled, value);
}

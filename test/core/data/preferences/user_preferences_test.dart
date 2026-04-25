import 'package:flutter_test/flutter_test.dart';
import 'package:qadr/core/constants/islamic_constants.dart';
import 'package:qadr/core/data/preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserPreferences> _buildPrefs([
  Map<String, Object> initial = const {},
]) async {
  SharedPreferences.setMockInitialValues(initial);
  return UserPreferences(await SharedPreferences.getInstance());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserPreferences defaults', () {
    test('onboardingComplete defaults to false', () async {
      final prefs = await _buildPrefs();
      expect(prefs.onboardingComplete, isFalse);
    });

    test('madhab defaults to hanafi (index 0)', () async {
      final prefs = await _buildPrefs();
      expect(prefs.madhab, Madhab.hanafi);
    });

    test('language defaults to "en"', () async {
      final prefs = await _buildPrefs();
      expect(prefs.language, 'en');
    });

    test('notificationsEnabled defaults to true', () async {
      final prefs = await _buildPrefs();
      expect(prefs.notificationsEnabled, isTrue);
    });

    test('nullable fields default to null', () async {
      final prefs = await _buildPrefs();
      expect(prefs.name, isNull);
      expect(prefs.latitude, isNull);
      expect(prefs.longitude, isNull);
      expect(prefs.cityName, isNull);
    });
  });

  group('UserPreferences round-trips', () {
    test('onboardingComplete persists through setter', () async {
      final prefs = await _buildPrefs();
      prefs.onboardingComplete = true;
      expect(prefs.onboardingComplete, isTrue);
    });

    test('each Madhab value round-trips by index', () async {
      for (final madhab in Madhab.values) {
        final prefs = await _buildPrefs();
        prefs.madhab = madhab;
        expect(prefs.madhab, madhab);
      }
    });

    test('language setter persists the string verbatim', () async {
      final prefs = await _buildPrefs();
      for (final lang in ['en', 'ar', 'ru']) {
        prefs.language = lang;
        expect(prefs.language, lang);
      }
    });

    test('name round-trips and clears via setting null', () async {
      final prefs = await _buildPrefs();
      prefs.name = 'Aisha';
      expect(prefs.name, 'Aisha');
      prefs.name = null;
      expect(prefs.name, isNull);
    });

    test('latitude round-trips and clears via null', () async {
      final prefs = await _buildPrefs();
      prefs.latitude = 41.31;
      expect(prefs.latitude, 41.31);
      prefs.latitude = null;
      expect(prefs.latitude, isNull);
    });

    test('longitude round-trips and clears via null', () async {
      final prefs = await _buildPrefs();
      prefs.longitude = 69.24;
      expect(prefs.longitude, 69.24);
      prefs.longitude = null;
      expect(prefs.longitude, isNull);
    });

    test('cityName round-trips and clears via null', () async {
      final prefs = await _buildPrefs();
      prefs.cityName = 'Tashkent';
      expect(prefs.cityName, 'Tashkent');
      prefs.cityName = null;
      expect(prefs.cityName, isNull);
    });

    test('notificationsEnabled persists both true and false', () async {
      final prefs = await _buildPrefs();
      prefs.notificationsEnabled = false;
      expect(prefs.notificationsEnabled, isFalse);
      prefs.notificationsEnabled = true;
      expect(prefs.notificationsEnabled, isTrue);
    });
  });

  group('UserPreferences reads from pre-populated storage', () {
    test('reads madhab by index across restarts', () async {
      final prefs = await _buildPrefs({'madhab': Madhab.hanbali.index});
      expect(prefs.madhab, Madhab.hanbali);
    });

    test('reads language, coordinates, and onboarding flag', () async {
      final prefs = await _buildPrefs({
        'language': 'ru',
        'latitude': 55.7558,
        'longitude': 37.6173,
        'city_name': 'Moscow',
        'onboarding_complete': true,
      });
      expect(prefs.language, 'ru');
      expect(prefs.latitude, 55.7558);
      expect(prefs.longitude, 37.6173);
      expect(prefs.cityName, 'Moscow');
      expect(prefs.onboardingComplete, isTrue);
    });
  });
}

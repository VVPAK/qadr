import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/preferences/user_preferences.dart';

final userPreferencesProvider = FutureProvider<UserPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return UserPreferences(prefs);
});

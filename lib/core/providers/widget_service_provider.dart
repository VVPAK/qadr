import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/widget_service.dart';
import 'preferences_provider.dart';

final widgetServiceProvider = Provider<WidgetService?>((ref) {
  final prefs = ref.watch(userPreferencesProvider).valueOrNull;
  if (prefs == null) return null;
  return WidgetService(prefs);
});

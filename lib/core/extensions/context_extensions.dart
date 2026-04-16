import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

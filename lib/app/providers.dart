import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localProvider = StateProvider<Locale>((ref) => const Locale('en'));
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

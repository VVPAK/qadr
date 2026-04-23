import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Serve Google Fonts from the bundled google_fonts/ asset directory
  // instead of fetching from the network. Fonts must exist in google_fonts/
  // with names matching the google_fonts package convention (e.g. Fraunces-Regular.ttf).
  GoogleFonts.config.allowRuntimeFetching = false;
  await testMain();
}

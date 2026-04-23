// Isolates the flutter_driver import so the package is only loaded
// when integration tests opt in via --dart-define=ENABLE_DRIVER=true.
// On iOS 26 devices the driver socket can crash the Dart VM at startup,
// so we never enable it by default.

// flutter_driver is a dev_dependency used only by integration drive tests.
// ignore: depend_on_referenced_packages
import 'package:flutter_driver/driver_extension.dart';

void enableDriverExtensionIfRequested() {
  enableFlutterDriverExtension();
}

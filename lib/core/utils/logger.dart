import 'dart:developer' as developer;

abstract final class Log {
  static void d(String message, {String tag = 'Qadr'}) {
    developer.log(message, name: tag);
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = 'Qadr',
  }) {
    developer.log(
      message,
      name: tag,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}

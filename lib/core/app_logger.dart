import 'dart:developer' as dev;

class AppLogger {
  const AppLogger();

  void i(String message) {
    dev.log(message, name: 'INFO');
  }

  void d(String message) {
    dev.log(message, name: 'DEBUG');
  }

  void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    dev.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

const appLogger = AppLogger();



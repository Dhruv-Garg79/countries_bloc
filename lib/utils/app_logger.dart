import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _loggerInstance = AppLogger._makeInstance();

  factory AppLogger() {
    return _loggerInstance;
  }

  AppLogger._makeInstance();

  static final _logger = Logger(
    printer: PrettyPrinter(
      printEmojis: true,
      printTime: false,
      methodCount: 0,
    ),
  );

  static void print(String value) {
    if (!kReleaseMode) {
      _logger.d(value);
    }
  }
}

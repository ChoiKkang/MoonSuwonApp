import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  filter: _AppLogFilter(),
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 100,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

class AppLogger {
  AppLogger._();

  static void network(String message, {dynamic data}) {
    _logger.i('🌐 $message${data != null ? '\n$data' : ''}');
  }

  static void auth(String message, {dynamic data}) {
    _logger.i('🔐 $message${data != null ? '\n$data' : ''}');
  }

  static void debug(String message, {dynamic data}) {
    _logger.d('🐛 $message${data != null ? '\n$data' : ''}');
  }

  static void info(String message, {dynamic data}) {
    _logger.i('ℹ️  $message${data != null ? '\n$data' : ''}');
  }

  static void warning(String message, {dynamic data}) {
    _logger.w('⚠️  $message${data != null ? '\n$data' : ''}');
  }

  static void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.e('❌ $message', error: error, stackTrace: stackTrace);
  }
}

class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kReleaseMode) return event.level.index >= Level.warning.index;
    return true;
  }
}

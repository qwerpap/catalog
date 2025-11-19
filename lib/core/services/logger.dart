import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  Logger._();

  static const String _tag = '[Catalog]';
  static bool _isEnabled = kDebugMode;

  static void enable() {
    _isEnabled = true;
  }

  static void disable() {
    _isEnabled = false;
  }

  static void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace, tag: tag);
  }

  static void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace, tag: tag);
  }

  static void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log(
      LogLevel.warning,
      message,
      error: error,
      stackTrace: stackTrace,
      tag: tag,
    );
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace, tag: tag);
  }

  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (!_isEnabled) return;

    final logTag = tag ?? _tag;
    final levelPrefix = _getLevelPrefix(level);
    final timestamp = DateTime.now().toIso8601String();

    final logMessage = '$logTag $levelPrefix [$timestamp] $message';

    if (error != null) {
      debugPrint('$logMessage\nError: $error');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    } else {
      debugPrint(logMessage);
    }
  }

  static String _getLevelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
    }
  }
}


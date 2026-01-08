// ignore_for_file: avoid_print

import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Log levels for categorizing log messages.
enum LogLevel {
  /// Debug information (only in debug mode).
  debug,

  /// General information.
  info,

  /// Warning messages.
  warning,

  /// Error messages.
  error,
}

/// Structured logger utility with level-based filtering.
///
/// Features:
/// - Level-based logging (debug, info, warning, error)
/// - Auto-disabled in release mode (except errors)
/// - Emoji prefixes for easy scanning
/// - Stack trace support for errors
///
/// Usage:
/// ```dart
/// Log.d('Debug message');
/// Log.i('Info message');
/// Log.w('Warning message');
/// Log.e('Error message', error: exception, stackTrace: stack);
/// ```
abstract final class Log {
  /// Whether to enable logging (auto-disabled in release).
  static bool _enabled = kDebugMode;

  /// Minimum log level to display.
  static LogLevel _minLevel = LogLevel.debug;

  /// Enable or disable all logging.
  static void setEnabled({required bool enabled}) => _enabled = enabled;

  /// Set minimum log level.
  static void setMinLevel(LogLevel level) => _minLevel = level;

  /// Log a debug message.
  ///
  /// Only shown in debug mode.
  static void d(String message, {String? tag, Object? data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  /// Log an info message.
  static void i(String message, {String? tag, Object? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  /// Log a warning message.
  static void w(String message, {String? tag, Object? data}) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  /// Log an error message.
  ///
  /// Errors are always logged, even in release mode.
  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Internal logging implementation.
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    // Always log errors, otherwise check enabled & level
    if (level != LogLevel.error) {
      if (!_enabled || level.index < _minLevel.index) return;
    }

    final emoji = _getEmoji(level);
    final levelName = level.name.toUpperCase();
    final tagPrefix = tag != null ? '[$tag] ' : '';
    final timestamp = DateTime.now().toIso8601String().substring(11, 23);

    final buffer = StringBuffer()
      ..writeln('$emoji $timestamp [$levelName] $tagPrefix$message');

    if (data != null) {
      buffer.writeln('   📦 Data: $data');
    }

    if (error != null) {
      buffer.writeln('   ❌ Error: $error');
    }

    if (stackTrace != null) {
      buffer.writeln('   📍 Stack Trace:');
      buffer.writeln(stackTrace.toString());
    }

    final output = buffer.toString();

    // Use dart:developer for better IDE integration
    if (kDebugMode) {
      developer.log(
        output,
        name: tag ?? 'App',
        level: _getDeveloperLevel(level),
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      // In release, only print errors
      if (level == LogLevel.error) {
        print(output);
      }
    }
  }

  /// Get emoji prefix for log level.
  static String _getEmoji(LogLevel level) {
    return switch (level) {
      LogLevel.debug => '🐛',
      LogLevel.info => 'ℹ️',
      LogLevel.warning => '⚠️',
      LogLevel.error => '🚨',
    };
  }

  /// Map to dart:developer log levels.
  static int _getDeveloperLevel(LogLevel level) {
    return switch (level) {
      LogLevel.debug => 500,
      LogLevel.info => 800,
      LogLevel.warning => 900,
      LogLevel.error => 1000,
    };
  }
}

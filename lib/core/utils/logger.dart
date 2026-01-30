import 'package:flutter/foundation.dart';

/// Debug logger for tracking app behavior
/// Only logs in debug mode
class Logger {
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';

  /// Log general debug information
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$_cyan DEBUG: $tagStr$message$_reset');
    }
  }

  /// Log API requests
  static void api(String message, {String? endpoint}) {
    if (kDebugMode) {
      final endpointStr = endpoint != null ? ' [$endpoint]' : '';
      print('$_blue API$endpointStr: $message$_reset');
    }
  }

  /// Log successful operations
  static void success(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$_green SUCCESS: $tagStr$message$_reset');
    }
  }

  /// Log warnings
  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$_yellow WARNING: $tagStr$message$_reset');
    }
  }

  /// Log errors with stack trace
  static void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag] ' : '';
      print('$_red ERROR: $tagStr$message$_reset');
      if (error != null) {
        print('$_red   Error details: $error$_reset');
      }
      if (stackTrace != null) {
        print('$_red   Stack trace:\n$stackTrace$_reset');
      }
    }
  }

  /// Log cache operations
  static void cache(String message, {bool hit = false}) {
    if (kDebugMode) {
      final status = hit ? 'HIT' : 'MISS';
      print('$_magenta CACHE $status: $message$_reset');
    }
  }

  /// Log database operations
  static void database(String message, {String? operation}) {
    if (kDebugMode) {
      final opStr = operation != null ? '[$operation] ' : '';
      print('$_cyan DB: $opStr$message$_reset');
    }
  }

  /// Log network status
  static void network(String message, {bool isOnline = true}) {
    if (kDebugMode) {
      final status = isOnline ? 'ONLINE' : 'OFFLINE';
      print('$_yellow NETWORK $status: $message$_reset');
    }
  }

  /// Log performance metrics
  static void performance(String message, {Duration? duration}) {
    if (kDebugMode) {
      final durationStr = duration != null ? ' (${duration.inMilliseconds}ms)' : '';
      print('$_magenta PERFORMANCE: $message$durationStr$_reset');
    }
  }

  /// Log navigation events
  static void navigation(String message) {
    if (kDebugMode) {
      print('$_blue NAVIGATION: $message$_reset');
    }
  }

  /// Create a separator line for better readability
  static void separator() {
    if (kDebugMode) {
      print('$_cyan${'=' * 80}$_reset');
    }
  }

  /// Log a section header
  static void section(String title) {
    if (kDebugMode) {
      separator();
      print('$_cyan $title$_reset');
      separator();
    }
  }
}

import 'package:flutter/widgets.dart';

/// Extensions on [num] for spacing, duration, and formatting utilities.
///
/// Note: For responsive sizing (`.w`, `.h`, `.sp`, `.r`), use
/// `flutter_screenutil` directly.
extension NumExtensions on num {
  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Horizontal gap widget.
  ///
  /// Usage: `16.horizontalGap`
  SizedBox get horizontalGap => SizedBox(width: toDouble());

  /// Vertical gap widget.
  ///
  /// Usage: `16.verticalGap`
  SizedBox get verticalGap => SizedBox(height: toDouble());

  // ═══════════════════════════════════════════════════════════════════════════
  // DURATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Duration in milliseconds.
  ///
  /// Usage: `300.ms`
  Duration get ms => Duration(milliseconds: toInt());

  /// Duration in seconds.
  ///
  /// Usage: `2.seconds`
  Duration get seconds => Duration(seconds: toInt());

  /// Duration in minutes.
  ///
  /// Usage: `5.minutes`
  Duration get minutes => Duration(minutes: toInt());

  // ═══════════════════════════════════════════════════════════════════════════
  // FORMATTING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Format as currency (IDR).
  ///
  /// Usage: `1500000.toCurrency()` → "Rp 1.500.000"
  String toCurrency({String symbol = 'Rp', int decimalDigits = 0}) {
    final value = toDouble();
    final parts = value.toStringAsFixed(decimalDigits).split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
    final decimalPart = parts.length > 1 ? ',${parts[1]}' : '';
    return '$symbol $integerPart$decimalPart';
  }

  /// Format with thousand separators.
  ///
  /// Usage: `1500000.withSeparators()` → "1.500.000"
  String withSeparators({String separator = '.'}) {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}$separator',
    );
  }

  /// Format as compact number.
  ///
  /// Usage: `1500000.toCompact()` → "1.5M"
  String toCompact() {
    final value = toDouble();
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }

  /// Format as percentage.
  ///
  /// Usage: `0.856.toPercentage()` → "85.6%"
  String toPercentage({int decimalDigits = 1}) {
    return '${(toDouble() * 100).toStringAsFixed(decimalDigits)}%';
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VALIDATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Check if value is between min and max (inclusive).
  bool isBetween(num min, num max) => this >= min && this <= max;

  /// Clamp value between min and max.
  num clampBetween(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}

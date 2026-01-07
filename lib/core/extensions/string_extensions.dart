import 'package:flutter_mvvm_boilerplate/core/constants/regex_patterns.dart';

/// String extensions for common string operations.
extension StringX on String {
  /// Capitalizes first letter: "hello" -> "Hello"
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Converts to title case: "hello world" -> "Hello World"
  String get titleCase => split(' ').map((w) => w.capitalized).join(' ');

  /// Checks if string is a valid email
  bool get isValidEmail => RegexPatterns.email.hasMatch(this);

  /// Checks if string is a valid phone number
  bool get isValidPhone => RegexPatterns.phone.hasMatch(this);

  /// Truncates string with ellipsis: "Hello World" -> "Hello..."
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}...';

  /// Removes all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Checks if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Checks if string is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Converts string to int, returns null if not valid
  int? toIntOrNull() => int.tryParse(this);

  /// Converts string to double, returns null if not valid
  double? toDoubleOrNull() => double.tryParse(this);
}

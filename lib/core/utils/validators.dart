import 'package:flutter_mvvm_boilerplate/core/constants/regex_patterns.dart';
import 'package:flutter_mvvm_boilerplate/core/extensions/string_extensions.dart';

/// Input validation utility functions.
abstract class Validators {
  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.isValidEmail) return 'Invalid email format';
    return null;
  }

  /// Validates password (min 8 chars, letters and numbers)
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegexPatterns.password.hasMatch(value)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  /// Validates phone number
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (!value.isValidPhone) return 'Invalid phone number';
    return null;
  }

  /// Validates required field
  static String? required(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(
    String? value,
    int min, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.length < min) {
      return '$fieldName must be at least $min characters';
    }
    return null;
  }

  /// Validates maximum length
  static String? maxLength(
    String? value,
    int max, [
    String fieldName = 'Field',
  ]) {
    if (value != null && value.length > max) {
      return '$fieldName must be at most $max characters';
    }
    return null;
  }

  /// Validates password confirmation matches
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirm password is required';
    if (value != password) return 'Passwords do not match';
    return null;
  }
}

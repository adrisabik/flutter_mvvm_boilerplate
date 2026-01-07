/// Regular expression patterns for validation.
abstract class RegexPatterns {
  /// Email validation pattern
  static final email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Phone validation pattern (international format)
  static final phone = RegExp(r'^\+?[0-9]{10,15}$');

  /// Password pattern (min 8 chars, at least one letter and one number)
  static final password = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$',
  );

  /// Alphanumeric only
  static final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

  /// URL pattern
  static final url = RegExp(r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$');

  /// Username pattern (alphanumeric, underscore, 3-20 chars)
  static final username = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  /// OTP pattern (4-6 digits)
  static final otp = RegExp(r'^\d{4,6}$');
}

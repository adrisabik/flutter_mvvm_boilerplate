/// Duration constants for animations, timeouts, and debounce.
abstract class AppDurations {
  // Network
  static const connectionTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);

  // Animation
  static const animationMicro = Duration(milliseconds: 100);
  static const animationFast = Duration(milliseconds: 150);
  static const animationShort = Duration(milliseconds: 200);
  static const animationNormal = Duration(milliseconds: 300);
  static const animationSlow = Duration(milliseconds: 500);
  static const animationLong = Duration(milliseconds: 600);

  // Debounce
  static const searchDebounce = Duration(milliseconds: 500);
  static const buttonDebounce = Duration(milliseconds: 300);
  static const formDebounce = Duration(milliseconds: 200);

  // Cache TTL
  static const cacheTTL = Duration(hours: 1);
  static const tokenRefreshBuffer = Duration(minutes: 5);

  // Splash
  static const splashDuration = Duration(seconds: 2);
}

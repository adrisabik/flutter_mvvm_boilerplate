/// Keys for local storage (SharedPreferences/Hive/SecureStorage).
abstract class StorageKeys {
  // Auth tokens (use secure storage)
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const userData = 'user_data';
  static const tokenExpiry = 'token_expiry';

  // User
  static const userId = 'user_id';
  static const userEmail = 'user_email';
  static const userName = 'user_name';

  // App state
  static const onboardingCompleted = 'onboarding_completed';
  static const isFirstLaunch = 'is_first_launch';

  // Preferences
  static const themeMode = 'theme_mode';
  static const locale = 'locale';
  static const biometricEnabled = 'biometric_enabled';

  // Cache
  static const lastCacheTime = 'last_cache_time';
}

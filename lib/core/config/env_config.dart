/// Environment configuration for different build flavors.
///
/// Supports both compile-time (--dart-define) and runtime configuration.
///
/// ## Usage with --dart-define
/// ```bash
/// # Development
/// flutter run --dart-define=FLAVOR=dev
///
/// # Staging
/// flutter run --dart-define=FLAVOR=staging
///
/// # Production
/// flutter run --dart-define=FLAVOR=prod
/// flutter build apk --dart-define=FLAVOR=prod
/// ```
enum Environment { dev, staging, prod }

/// Configuration values for the current environment.
class EnvConfig {
  const EnvConfig._({
    required this.environment,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.appName,
  });

  /// Development environment configuration
  static const EnvConfig dev = EnvConfig._(
    environment: Environment.dev,
    baseUrl: 'https://api.dev.example.com',
    apiKey: 'dev-api-key',
    enableLogging: true,
    appName: 'MVVM Dev',
  );

  /// Staging environment configuration
  static const EnvConfig staging = EnvConfig._(
    environment: Environment.staging,
    baseUrl: 'https://api.staging.example.com',
    apiKey: 'staging-api-key',
    enableLogging: true,
    appName: 'MVVM Staging',
  );

  /// Production environment configuration
  static const EnvConfig prod = EnvConfig._(
    environment: Environment.prod,
    baseUrl: 'https://api.example.com',
    apiKey: 'prod-api-key',
    enableLogging: false,
    appName: 'MVVM Boilerplate',
  );

  /// Environment type
  final Environment environment;

  /// Base API URL
  final String baseUrl;

  /// API key for authentication
  final String apiKey;

  /// Whether to enable logging
  final bool enableLogging;

  /// App name for this environment
  final String appName;

  /// Current active configuration.
  /// Set from --dart-define or manually in main.dart
  static EnvConfig current = _getFromDartDefine();

  /// Helper getters
  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
  bool get isDebugMode => isDev || isStaging;

  /// Gets the configuration from --dart-define FLAVOR
  static EnvConfig _getFromDartDefine() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor.toLowerCase()) {
      case 'prod':
      case 'production':
        return EnvConfig.prod;
      case 'staging':
      case 'stg':
        return EnvConfig.staging;
      case 'dev':
      case 'development':
      default:
        return EnvConfig.dev;
    }
  }

  /// Creates a custom config (useful for testing or overrides)
  static EnvConfig custom({
    Environment environment = Environment.dev,
    required String baseUrl,
    String apiKey = '',
    bool enableLogging = true,
    String appName = 'MVVM Custom',
  }) {
    return EnvConfig._(
      environment: environment,
      baseUrl: baseUrl,
      apiKey: apiKey,
      enableLogging: enableLogging,
      appName: appName,
    );
  }

  @override
  String toString() => 'EnvConfig($environment, $baseUrl)';
}

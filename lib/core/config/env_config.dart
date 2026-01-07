/// Environment configuration for different build flavors.
enum Environment { dev, staging, prod }

/// Configuration values for the current environment.
enum EnvConfig {
  /// Development environment configuration
  dev._(
    environment: Environment.dev,
    baseUrl: 'https://api.dev.example.com',
    apiKey: 'dev-api-key',
    enableLogging: true,
  ),

  /// Staging environment configuration
  staging._(
    environment: Environment.staging,
    baseUrl: 'https://api.staging.example.com',
    apiKey: 'staging-api-key',
    enableLogging: true,
  ),

  /// Production environment configuration
  prod._(
    environment: Environment.prod,
    baseUrl: 'https://api.example.com',
    apiKey: 'prod-api-key',
    enableLogging: false,
  );


  const EnvConfig._({
    required this.environment,
    required this.baseUrl,
    required this.apiKey,
    required this.enableLogging,
  });
  final Environment environment;
  final String baseUrl;
  final String apiKey;
  final bool enableLogging;

  /// Current active configuration
  static EnvConfig current = dev;

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}

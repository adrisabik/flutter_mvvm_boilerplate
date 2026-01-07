import 'package:dio/dio.dart';
import 'package:flutter_mvvm_boilerplate/core/config/env_config.dart';
import 'package:flutter_mvvm_boilerplate/core/constants/app_durations.dart';

/// Dio HTTP client configuration.
class DioClient {

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.current.baseUrl,
        connectTimeout: AppDurations.connectionTimeout,
        receiveTimeout: AppDurations.receiveTimeout,
        sendTimeout: AppDurations.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }
  late final Dio _dio;

  Dio get dio => _dio;

  void _setupInterceptors() {
    // Logging interceptor (only in dev)
    if (EnvConfig.current.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          responseHeader: false,
        ),
      );
    }

    // TODO: Add AuthInterceptor for token management
    // TODO: Add ErrorInterceptor for global error handling
  }

  /// Sets the authorization header with the provided token.
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Removes the authorization header.
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}

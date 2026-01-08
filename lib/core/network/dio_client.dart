import 'package:dio/dio.dart';
import 'package:flutter_mvvm_boilerplate/core/config/env_config.dart';
import 'package:flutter_mvvm_boilerplate/core/constants/app_durations.dart';
import 'package:flutter_mvvm_boilerplate/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_mvvm_boilerplate/core/network/interceptors/error_interceptor.dart';
import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';

/// Dio HTTP client configuration.
class DioClient {
  DioClient(this._storageService) {
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

  final SecureStorageService _storageService;
  late final Dio _dio;

  Dio get dio => _dio;

  void _setupInterceptors() {
    // Order matters: Auth -> Error -> Logging
    // Auth interceptor for token management
    _dio.interceptors.add(AuthInterceptor(_storageService, _dio));

    // Error interceptor for global error handling
    _dio.interceptors.add(ErrorInterceptor());

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

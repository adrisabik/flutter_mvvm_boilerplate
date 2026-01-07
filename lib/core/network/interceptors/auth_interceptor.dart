import 'package:dio/dio.dart';

import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';

/// Interceptor for handling authentication headers and token refresh.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storageService, this._dio);
  final SecureStorageService _storageService;
  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add token to headers if available
    final token = await _storageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - attempt token refresh
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storageService.getRefreshToken();
        if (refreshToken != null) {
          // Attempt to refresh token
          final response = await _dio.post<Map<String, dynamic>>(
            '/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final data = response.data!;
            final newToken = data['access_token'] as String;
            await _storageService.saveAccessToken(newToken);

            // Retry the original request with new token
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final retryResponse = await _dio.fetch<dynamic>(err.requestOptions);
            return handler.resolve(retryResponse);
          }
        }
      } on DioException {
        // Token refresh failed - clear tokens and let error propagate
        await _storageService.clearTokens();
      }
    }
    handler.next(err);
  }
}

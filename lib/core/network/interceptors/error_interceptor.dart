import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_mvvm_boilerplate/core/error/exceptions.dart';

/// Interceptor for handling and transforming API errors.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioExceptionToAppException(err);

    debugPrint('🔴 API Error: ${exception.message}');
    debugPrint('   Status: ${err.response?.statusCode}');
    debugPrint('   Path: ${err.requestOptions.path}');

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
      ),
    );
  }

  AppException _mapDioExceptionToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'Connection timed out. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const NetworkException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(err.response);

      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Security certificate error.');

      case DioExceptionType.unknown:
        return ServerException(
          message: err.message ?? 'An unexpected error occurred.',
        );
    }
  }

  AppException _handleBadResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;

    // Try to extract message from response
    var message = 'Something went wrong.';
    if (data is Map<String, dynamic>) {
      message =
          data['message'] as String? ?? data['error'] as String? ?? message;
    }

    switch (statusCode) {
      case 400:
        return ServerException(message: message, statusCode: 400);
      case 401:
        return AuthException(message: message);
      case 403:
        return const AuthException(message: 'Access denied.');
      case 404:
        return NotFoundException(message: message);
      case 422:
        return ServerException(message: message, statusCode: 422);
      case 500:
      case 502:
      case 503:
        return const ServerException(
          message: 'Server error. Please try again later.',
          statusCode: 500,
        );
      default:
        return ServerException(message: message, statusCode: statusCode);
    }
  }
}

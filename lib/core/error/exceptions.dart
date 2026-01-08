/// Base exception class for custom exceptions.
abstract class AppException implements Exception {
  const AppException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Exception thrown when server returns an error.
class ServerException extends AppException {
  const ServerException({required super.message, super.code, this.statusCode});

  final int? statusCode;

  /// Check if error is client side (4xx)
  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! < 500;

  /// Check if error is server side (5xx)
  bool get isServerError => statusCode != null && statusCode! >= 500;

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

/// Exception thrown when cache operation fails.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache operation failed',
    super.code = 'CACHE_ERROR',
  });
}

/// Exception thrown when network is unavailable.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code = 'NETWORK_ERROR',
  });
}

/// Exception thrown for authentication errors.
class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.code = 'AUTH_ERROR',
    this.isTokenExpired = false,
  });

  /// Whether the token has expired and needs refresh.
  final bool isTokenExpired;
}

/// Exception thrown when a resource is not found.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
  });
}

/// Exception thrown when request times out.
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out',
    super.code = 'TIMEOUT_ERROR',
  });
}

/// Exception thrown when request is cancelled.
class CancelledException extends AppException {
  const CancelledException({
    super.message = 'Request was cancelled',
    super.code = 'CANCELLED',
  });
}

/// Exception thrown for validation errors.
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    this.fieldErrors,
  });

  /// Field-specific validation errors.
  final Map<String, String>? fieldErrors;
}

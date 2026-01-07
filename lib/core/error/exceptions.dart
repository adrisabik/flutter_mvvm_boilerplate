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
  });
}

/// Exception thrown when a resource is not found.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
  });
}

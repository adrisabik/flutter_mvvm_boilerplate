import 'package:equatable/equatable.dart';

/// Base failure class for error handling.
/// All failures should extend this class.
abstract class Failure extends Equatable {

  const Failure({required this.message, this.code});
  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// Failure from server/network operations.
class ServerFailure extends Failure {

  const ServerFailure({required super.message, super.code, this.statusCode});
  final int? statusCode;

  @override
  List<Object?> get props => [message, code, statusCode];
}

/// Failure from local cache operations.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Failure from input validation.
class ValidationFailure extends Failure {

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
  final Map<String, String>? fieldErrors;

  @override
  List<Object?> get props => [message, code, fieldErrors];
}

/// Failure when network is unavailable.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.code = 'NETWORK_ERROR',
  });
}

/// Failure for authentication errors.
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code = 'AUTH_ERROR'});
}

/// Unknown/unexpected failure.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred',
    super.code = 'UNKNOWN_ERROR',
  });
}

import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

/// Authentication repository interface.
///
/// Defines the contract for authentication operations.
/// Implementations can use different data sources (API, Firebase, etc.)
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? name,
  });

  /// Logout the current user
  Future<Either<Failure, void>> logout();

  /// Get the currently authenticated user
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Get stored auth token
  Future<String?> getToken();

  /// Refresh the auth token
  Future<Either<Failure, String>> refreshToken();
}

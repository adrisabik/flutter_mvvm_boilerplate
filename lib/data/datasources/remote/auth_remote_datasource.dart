import 'package:dio/dio.dart';
import 'package:flutter_mvvm_boilerplate/core/error/exceptions.dart';
import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

/// Remote data source for authentication operations.
///
/// Handles all API calls related to authentication:
/// - Login
/// - Registration
/// - Token refresh
/// - Logout
abstract class AuthRemoteDataSource {
  /// Authenticates user with email and password.
  ///
  /// Returns [AuthResponse] with user and tokens on success.
  /// Throws [ServerException] or [AuthException] on failure.
  Future<AuthResponse> login({required String email, required String password});

  /// Registers a new user.
  ///
  /// Returns [AuthResponse] with user and tokens on success.
  /// Throws [ServerException] or [ValidationException] on failure.
  Future<AuthResponse> register({
    required String email,
    required String password,
    String? name,
  });

  /// Refreshes the access token using refresh token.
  ///
  /// Returns new access token on success.
  /// Throws [AuthException] if refresh token is invalid.
  Future<String> refreshToken(String refreshToken);

  /// Logs out the current user on the server side.
  Future<void> logout();

  /// Gets current user profile from server.
  Future<User> getCurrentUser();
}

/// Response from authentication endpoints.
class AuthResponse {
  const AuthResponse({
    required this.user,
    required this.accessToken,
    this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  final User user;
  final String accessToken;
  final String? refreshToken;
}

/// Implementation of [AuthRemoteDataSource].
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return AuthResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error as AppException? ??
          const ServerException(message: 'Login failed');
    }
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          if (name != null) 'name': name,
        },
      );

      return AuthResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error as AppException? ??
          const ServerException(message: 'Registration failed');
    }
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      return response.data!['access_token'] as String;
    } on DioException catch (e) {
      throw e.error as AppException? ??
          const AuthException(message: 'Token refresh failed');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post<void>('/auth/logout');
    } on DioException {
      // Ignore logout errors - we'll clear local tokens anyway
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/auth/me');

      return User.fromJson(response.data!);
    } on DioException catch (e) {
      throw e.error as AppException? ??
          const AuthException(message: 'Failed to get user');
    }
  }
}

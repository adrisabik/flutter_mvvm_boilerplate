import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm_boilerplate/core/error/exceptions.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Implementation of AuthRepository using Dio for API calls.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dioClient, this._storageService);
  final DioClient _dioClient;
  final SecureStorageService _storageService;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final data = response.data!;

      // Save tokens
      if (data['access_token'] != null) {
        await _storageService.saveAccessToken(data['access_token'] as String);
      }
      if (data['refresh_token'] != null) {
        await _storageService.saveRefreshToken(data['refresh_token'] as String);
      }

      // Parse user
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      await _storageService.saveUserData(jsonEncode(user.toJson()));

      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await _dioClient.dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          if (name != null) 'name': name,
        },
      );

      final data = response.data!;

      // Save tokens
      if (data['access_token'] != null) {
        await _storageService.saveAccessToken(data['access_token'] as String);
      }
      if (data['refresh_token'] != null) {
        await _storageService.saveRefreshToken(data['refresh_token'] as String);
      }

      // Parse user
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      await _storageService.saveUserData(jsonEncode(user.toJson()));

      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Call logout endpoint (optional, some APIs don't have this)
      try {
        await _dioClient.dio.post<void>('/auth/logout');
      } on DioException catch (_) {
        // Ignore API errors on logout
      }

      // Clear local data
      await _storageService.clearTokens();
      await _storageService.clearUserData();
      _dioClient.clearAuthToken();

      return const Right(null);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // First try to get from local storage
      final userData = await _storageService.getUserData();
      if (userData != null) {
        final user = User.fromJson(
          jsonDecode(userData) as Map<String, dynamic>,
        );
        return Right(user);
      }

      // If not in storage, fetch from API
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '/auth/me',
      );
      final user = User.fromJson(response.data!);
      await _storageService.saveUserData(jsonEncode(user.toJson()));

      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return _storageService.getAccessToken();
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        return const Left(AuthFailure(message: 'No refresh token available'));
      }

      final response = await _dioClient.dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final data = response.data!;
      final newToken = data['access_token'] as String;
      await _storageService.saveAccessToken(newToken);

      if (data['refresh_token'] != null) {
        await _storageService.saveRefreshToken(data['refresh_token'] as String);
      }

      return Right(newToken);
    } on AuthException catch (e) {
      await _storageService.clearTokens();
      return Left(AuthFailure(message: e.message));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}

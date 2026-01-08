import 'dart:convert';

import 'package:flutter_mvvm_boilerplate/core/error/exceptions.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';
import 'package:flutter_mvvm_boilerplate/data/repositories/auth_repository_impl.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late AuthRepositoryImpl repository;
  late MockDioClient mockDioClient;
  late MockSecureStorageService mockStorageService;

  setUp(() {
    mockDioClient = MockDioClient();
    mockStorageService = MockSecureStorageService();
    repository = AuthRepositoryImpl(mockDioClient, mockStorageService);
  });

  final tUser = User(id: '1', email: 'test@example.com', name: 'Test User');

  group('isLoggedIn', () {
    test('should return true when access token exists', () async {
      // Arrange
      when(
        () => mockStorageService.getAccessToken(),
      ).thenAnswer((_) async => 'valid_token');

      // Act
      final result = await repository.isLoggedIn();

      // Assert
      expect(result, true);
      verify(() => mockStorageService.getAccessToken()).called(1);
    });

    test('should return false when access token is null', () async {
      // Arrange
      when(
        () => mockStorageService.getAccessToken(),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repository.isLoggedIn();

      // Assert
      expect(result, false);
    });

    test('should return false when access token is empty', () async {
      // Arrange
      when(
        () => mockStorageService.getAccessToken(),
      ).thenAnswer((_) async => '');

      // Act
      final result = await repository.isLoggedIn();

      // Assert
      expect(result, false);
    });
  });

  group('getToken', () {
    test('should return token from storage service', () async {
      // Arrange
      const tToken = 'test_access_token';
      when(
        () => mockStorageService.getAccessToken(),
      ).thenAnswer((_) async => tToken);

      // Act
      final result = await repository.getToken();

      // Assert
      expect(result, tToken);
      verify(() => mockStorageService.getAccessToken()).called(1);
    });

    test('should return null when no token stored', () async {
      // Arrange
      when(
        () => mockStorageService.getAccessToken(),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repository.getToken();

      // Assert
      expect(result, null);
    });
  });

  group('getCurrentUser', () {
    test('should return user from storage when available', () async {
      // Arrange
      when(
        () => mockStorageService.getUserData(),
      ).thenAnswer((_) async => jsonEncode(tUser.toJson()));

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Expected Right'), (user) {
        expect(user.id, tUser.id);
        expect(user.email, tUser.email);
      });
    });
  });

  group('logout', () {
    test('should clear all tokens and user data', () async {
      // Arrange
      when(() => mockStorageService.clearTokens()).thenAnswer((_) async {});
      when(() => mockStorageService.clearUserData()).thenAnswer((_) async {});
      when(() => mockDioClient.clearAuthToken()).thenReturn(null);

      // Act
      final result = await repository.logout();

      // Assert
      expect(result.isRight(), true);
      verify(() => mockStorageService.clearTokens()).called(1);
      verify(() => mockStorageService.clearUserData()).called(1);
      verify(() => mockDioClient.clearAuthToken()).called(1);
    });
  });
}

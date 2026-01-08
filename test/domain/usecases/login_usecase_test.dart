import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  final tUser = User(id: '1', email: 'test@example.com', name: 'Test User');

  const tParams = LoginParams(
    email: 'test@example.com',
    password: 'password123',
  );

  group('LoginUseCase', () {
    test('should return User when login is successful', () async {
      // Arrange
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(tUser));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, Right<Failure, User>(tUser));
      verify(
        () => mockAuthRepository.login(
          email: tParams.email,
          password: tParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test(
      'should return AuthFailure when login fails with auth error',
      () async {
        // Arrange
        const tFailure = AuthFailure(message: 'Invalid credentials');
        when(
          () => mockAuthRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // Act
        final result = await useCase(tParams);

        // Assert
        expect(result, const Left<Failure, User>(tFailure));
        verify(
          () => mockAuthRepository.login(
            email: tParams.email,
            password: tParams.password,
          ),
        ).called(1);
      },
    );

    test('should return NetworkFailure when no internet connection', () async {
      // Arrange
      const tFailure = NetworkFailure();
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, isA<Left<Failure, User>>());
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('should return ServerFailure when server error occurs', () async {
      // Arrange
      const tFailure = ServerFailure(
        message: 'Internal server error',
        statusCode: 500,
      );
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, const Left<Failure, User>(tFailure));
    });
  });
}

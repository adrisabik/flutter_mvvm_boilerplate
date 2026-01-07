import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_mvvm_boilerplate/core/error/failures.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/usecase.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/bloc/auth_event.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late AuthBloc authBloc;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      logoutUseCase: mockLogoutUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  setUpAll(() {
    registerFallbackValue(const LoginParams(email: '', password: ''));
    registerFallbackValue(const NoParams());
  });

  group('AuthBloc', () {
    const testUser = User(
      id: 'user_123',
      email: 'test@example.com',
      name: 'Test User',
    );

    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('initial state is AuthInitial', () {
      expect(authBloc.state, const AuthState.initial());
    });

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login succeeds',
        build: () {
          when(
            () => mockLoginUseCase(any()),
          ).thenAnswer((_) async => const Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(
            email: testEmail,
            password: testPassword,
          ),
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.authenticated(
            userId: 'user_123',
            email: 'test@example.com',
            name: 'Test User',
          ),
        ],
        verify: (_) {
          verify(
            () => mockLoginUseCase(
              const LoginParams(email: testEmail, password: testPassword),
            ),
          ).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login fails',
        build: () {
          when(() => mockLoginUseCase(any())).thenAnswer(
            (_) async =>
                const Left(AuthFailure(message: 'Invalid credentials')),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(
            email: testEmail,
            password: 'wrong_password',
          ),
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Invalid credentials'),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when logout succeeds',
        build: () {
          when(
            () => mockLogoutUseCase(any()),
          ).thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
        verify: (_) {
          verify(() => mockLogoutUseCase(const NoParams())).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when logout fails',
        build: () {
          when(() => mockLogoutUseCase(any())).thenAnswer(
            (_) async => const Left(UnknownFailure(message: 'Logout failed')),
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
        expect: () => [
          const AuthState.loading(),
          const AuthState.error(message: 'Logout failed'),
        ],
      );
    });
  });
}

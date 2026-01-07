import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_mvvm_boilerplate/core/di/injection.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/logout_usecase.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/usecase.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/bloc/auth_event.dart';
import 'package:flutter_mvvm_boilerplate/presentation/auth/bloc/auth_state.dart';

/// Auth BLoC for managing authentication state.
///
/// Uses real repository through use cases for production.
/// To use mock implementation, swap the repository in injection.dart.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({LoginUseCase? loginUseCase, LogoutUseCase? logoutUseCase})
    : _loginUseCase = loginUseCase ?? sl<LoginUseCase>(),
      _logoutUseCase = logoutUseCase ?? sl<LogoutUseCase>(),
      super(const AuthState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (user) => emit(
        AuthState.authenticated(
          userId: user.id,
          email: user.email,
          name: user.name,
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _logoutUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    // Check if logged in via repository

    // For now, just emit unauthenticated - in real app, check stored token
    emit(const AuthState.unauthenticated());
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/core/session/session_state.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Global session manager for authentication state.
///
/// This cubit should be provided at the root of the app and used
/// to manage the user's session state throughout the application.
///
/// ## Setup
/// ```dart
/// BlocProvider(
///   create: (_) => sl<SessionCubit>()..checkSession(),
///   child: const App(),
/// )
/// ```
///
/// ## Usage
///
/// Check if user is authenticated:
/// ```dart
/// final isLoggedIn = context.read<SessionCubit>().state.isAuthenticated;
/// ```
///
/// Get current user:
/// ```dart
/// final user = context.read<SessionCubit>().state.user;
/// ```
///
/// Listen for session changes (e.g., for logout):
/// ```dart
/// BlocListener<SessionCubit, SessionState>(
///   listenWhen: (prev, curr) => curr is _Unauthenticated || curr is _Expired,
///   listener: (context, state) {
///     context.goNamed(RouteNames.login);
///   },
///   child: ...
/// )
/// ```
@lazySingleton
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._authRepository) : super(const SessionState.initial());

  final AuthRepository _authRepository;

  /// Check current session status.
  ///
  /// Call this at app startup to determine initial navigation.
  Future<void> checkSession() async {
    emit(const SessionState.loading());

    final isLoggedIn = await _authRepository.isLoggedIn();

    if (!isLoggedIn) {
      emit(const SessionState.unauthenticated());
      return;
    }

    // Validate token by fetching user
    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) {
        // Token is invalid or expired
        emit(const SessionState.expired());
      },
      (user) {
        emit(SessionState.authenticated(user));
      },
    );
  }

  /// Called when user successfully logs in.
  void onLoginSuccess(User user) {
    emit(SessionState.authenticated(user));
  }

  /// Called when user logs out.
  Future<void> logout() async {
    await _authRepository.logout();
    emit(const SessionState.unauthenticated());
  }

  /// Called when session expires (e.g., from 401 response).
  void onSessionExpired() {
    emit(const SessionState.expired());
  }

  /// Update the current user.
  void updateUser(User user) {
    if (state.isAuthenticated) {
      emit(SessionState.authenticated(user));
    }
  }

  /// Force refresh the session.
  Future<void> refreshSession() async {
    if (!state.isAuthenticated) return;

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (_) => emit(const SessionState.expired()),
      (user) => emit(SessionState.authenticated(user)),
    );
  }
}

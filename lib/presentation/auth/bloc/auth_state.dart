import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Auth states for the AuthBloc.
@freezed
class AuthState with _$AuthState {
  /// Initial state before auth check
  const factory AuthState.initial() = AuthInitial;

  /// Loading state during auth operations
  const factory AuthState.loading() = AuthLoading;

  /// Authenticated state with user info
  const factory AuthState.authenticated({
    required String userId,
    required String email,
    String? name,
  }) = AuthAuthenticated;

  /// Unauthenticated state (logged out)
  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  /// Error state with message
  const factory AuthState.error({required String message}) = AuthError;
}

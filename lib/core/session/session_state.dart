import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_mvvm_boilerplate/domain/entities/user.dart';

part 'session_state.freezed.dart';

/// State representing the current user session.
@freezed
class SessionState with _$SessionState {
  /// Initial state before checking auth status.
  const factory SessionState.initial() = _Initial;

  /// Currently checking authentication status.
  const factory SessionState.loading() = _Loading;

  /// User is authenticated.
  const factory SessionState.authenticated(User user) = _Authenticated;

  /// User is not authenticated.
  const factory SessionState.unauthenticated() = _Unauthenticated;

  /// Session expired (token expired).
  const factory SessionState.expired() = _Expired;
}

/// Extension methods for SessionState.
extension SessionStateX on SessionState {
  /// Returns true if user is authenticated.
  bool get isAuthenticated =>
      maybeWhen(authenticated: (_) => true, orElse: () => false);

  /// Returns true if session has expired.
  bool get hasExpired => maybeWhen(expired: () => true, orElse: () => false);

  /// Returns the current user if authenticated.
  User? get user =>
      maybeWhen(authenticated: (user) => user, orElse: () => null);
}

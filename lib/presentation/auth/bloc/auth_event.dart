import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

/// Auth events for the AuthBloc.
@freezed
class AuthEvent with _$AuthEvent {
  /// Login request event
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = LoginRequested;

  /// Logout request event
  const factory AuthEvent.logoutRequested() = LogoutRequested;

  /// Check auth status event
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;
}

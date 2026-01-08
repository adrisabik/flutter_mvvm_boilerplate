import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

/// State for the splash/initialization screen.
@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.loading({String? message}) = _Loading;
  const factory SplashState.authenticated() = _Authenticated;
  const factory SplashState.unauthenticated() = _Unauthenticated;
  const factory SplashState.error({required String message}) = _Error;
}

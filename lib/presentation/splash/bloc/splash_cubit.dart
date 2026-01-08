import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/presentation/splash/bloc/splash_state.dart';
import 'package:injectable/injectable.dart';

/// Cubit for handling app initialization and auth state check.
///
/// This cubit is responsible for:
/// 1. Checking if user is authenticated
/// 2. Pre-loading any necessary app config
/// 3. Determining initial navigation target
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository) : super(const SplashState.initial());

  final AuthRepository _authRepository;

  /// Initialize the app and check authentication status.
  Future<void> initialize() async {
    emit(const SplashState.loading(message: 'Checking authentication...'));

    try {
      // Add a minimum delay for better UX (avoid flash)
      await Future<void>.delayed(const Duration(milliseconds: 1500));

      // Check if user is logged in
      final isLoggedIn = await _authRepository.isLoggedIn();

      if (isLoggedIn) {
        // Optionally validate token by fetching current user
        final userResult = await _authRepository.getCurrentUser();

        userResult.fold(
          // Token invalid - user needs to login again
          (_) => emit(const SplashState.unauthenticated()),
          // Token valid - user is authenticated
          (_) => emit(const SplashState.authenticated()),
        );
      } else {
        emit(const SplashState.unauthenticated());
      }
    } on Exception catch (e) {
      emit(SplashState.error(message: e.toString()));
    }
  }

  /// Retry initialization after an error.
  void retry() {
    initialize();
  }
}

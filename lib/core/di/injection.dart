import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.config.dart';
import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/core/network/network_info.dart';
import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';
import 'package:flutter_mvvm_boilerplate/data/repositories/auth_repository_impl.dart';
import 'package:flutter_mvvm_boilerplate/domain/repositories/auth_repository.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_mvvm_boilerplate/domain/usecases/auth/logout_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Initialize all dependencies.
@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() async {
  // Register core dependencies manually (before injectable)
  _registerCoreDependencies();
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();

  // Initialize injectable dependencies
  sl.init();
}

void _registerCoreDependencies() {
  // Network
  sl
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<DioClient>(DioClient.new);
}

void _registerDataSources() {
  // Local
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
}

void _registerRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
}

void _registerUseCases() {
  // Auth
  sl
    ..registerFactory<LoginUseCase>(() => LoginUseCase(sl()))
    ..registerFactory<LogoutUseCase>(() => LogoutUseCase(sl()));
}

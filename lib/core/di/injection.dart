import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_mvvm_boilerplate/core/di/injection.config.dart';
import 'package:flutter_mvvm_boilerplate/core/network/dio_client.dart';
import 'package:flutter_mvvm_boilerplate/core/network/network_info.dart';
import 'package:flutter_mvvm_boilerplate/data/datasources/local/secure_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Initialize all dependencies.
///
/// This function:
/// 1. Registers core dependencies that need manual setup
/// 2. Initializes injectable-generated dependencies
@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() async {
  // Register core dependencies manually (before injectable)
  // These are registered first because injectable deps may depend on them
  _registerCoreDependencies();

  // Initialize injectable dependencies
  // This registers all classes annotated with @injectable, @singleton, etc.
  sl.init();
}

void _registerCoreDependencies() {
  // Core services that need manual setup
  sl
    // Connectivity
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    // Network info
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    // Secure storage (needed by DioClient)
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    // Dio client (depends on SecureStorageService)
    ..registerLazySingleton<DioClient>(() => DioClient(sl()));
}

/// Module for third-party dependencies that need @injectable annotations.
@module
abstract class RegisterModule {
  /// Provides [Connectivity] instance.
  @lazySingleton
  Connectivity get connectivity => sl<Connectivity>();

  /// Provides [NetworkInfo] instance.
  @lazySingleton
  NetworkInfo get networkInfo => sl<NetworkInfo>();

  /// Provides [SecureStorageService] instance.
  @lazySingleton
  SecureStorageService get secureStorageService => sl<SecureStorageService>();

  /// Provides [DioClient] instance.
  @lazySingleton
  DioClient get dioClient => sl<DioClient>();
}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/local/secure_storage_service.dart' as _i269;
import '../../data/datasources/remote/auth_remote_datasource.dart' as _i1057;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/usecases/auth/login_usecase.dart' as _i461;
import '../../domain/usecases/auth/logout_usecase.dart' as _i320;
import '../../presentation/splash/bloc/splash_cubit.dart' as _i331;
import '../network/connectivity_cubit.dart' as _i838;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../session/session_cubit.dart' as _i796;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i932.NetworkInfo>(() => registerModule.networkInfo);
    gh.lazySingleton<_i269.SecureStorageService>(
      () => registerModule.secureStorageService,
    );
    gh.lazySingleton<_i667.DioClient>(() => registerModule.dioClient);
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(
        gh<_i667.DioClient>(),
        gh<_i269.SecureStorageService>(),
      ),
    );
    gh.factory<_i838.ConnectivityCubit>(
      () => _i838.ConnectivityCubit(
        gh<_i895.Connectivity>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.factory<_i461.LoginUseCase>(
      () => _i461.LoginUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.factory<_i320.LogoutUseCase>(
      () => _i320.LogoutUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i1057.AuthRemoteDataSource>(
      () => _i1057.AuthRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i796.SessionCubit>(
      () => _i796.SessionCubit(gh<_i1073.AuthRepository>()),
    );
    gh.factory<_i331.SplashCubit>(
      () => _i331.SplashCubit(gh<_i1073.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}

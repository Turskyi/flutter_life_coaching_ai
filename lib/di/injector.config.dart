// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_repository/authentication_repository.dart'
    as _i223;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lifecoach/application_services/authentication/bloc/authentication_bloc.dart'
    as _i698;
import 'package:lifecoach/application_services/sign_in/bloc/sign_in_bloc.dart'
    as _i1032;
import 'package:lifecoach/di/authentication_repository_module.dart' as _i413;
import 'package:lifecoach/di/dio_http_client_module.dart' as _i1000;
import 'package:lifecoach/di/preferences_module.dart' as _i78;
import 'package:lifecoach/di/retrofit_http_client_module.dart' as _i696;
import 'package:lifecoach/di/user_repository_module.dart' as _i960;
import 'package:lifecoach/infrastructure/ws/rest/logging_interceptor.dart'
    as _i865;
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart'
    as _i1073;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:user_repository/user_repository.dart' as _i164;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initDependencyInjection({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final dioHttpClientModule = _$DioHttpClientModule();
    final retrofitHttpClientModule = _$RetrofitHttpClientModule();
    final userRepositoryModule = _$UserRepositoryModule();
    final authenticationRepositoryModule = _$AuthenticationRepositoryModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i865.LoggingInterceptor>(
        () => const _i865.LoggingInterceptor());
    gh.lazySingleton<_i361.Dio>(() =>
        dioHttpClientModule.getDioHttpClient(gh<_i865.LoggingInterceptor>()));
    gh.lazySingleton<_i1073.RetrofitClient>(
        () => retrofitHttpClientModule.getRestClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i164.UserRepository>(() =>
        userRepositoryModule.getUserRepository(gh<_i1073.RetrofitClient>()));
    gh.lazySingleton<_i223.AuthenticationRepository>(
        () => authenticationRepositoryModule.getAuthenticationRepository(
              gh<_i1073.RetrofitClient>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i698.AuthenticationBloc>(() => _i698.AuthenticationBloc(
          authenticationRepository: gh<_i223.AuthenticationRepository>(),
          userRepository: gh<_i164.UserRepository>(),
        ));
    gh.factory<_i1032.SignInBloc>(() => _i1032.SignInBloc(
        authenticationRepository: gh<_i223.AuthenticationRepository>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i78.SharedPreferencesModule {}

class _$DioHttpClientModule extends _i1000.DioHttpClientModule {}

class _$RetrofitHttpClientModule extends _i696.RetrofitHttpClientModule {}

class _$UserRepositoryModule extends _i960.UserRepositoryModule {}

class _$AuthenticationRepositoryModule
    extends _i413.AuthenticationRepositoryModule {}

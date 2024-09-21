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
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart'
    as _i73;
import 'package:lifecoach/application_services/blocs/chat/bloc/chat_bloc.dart'
    as _i489;
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart'
    as _i989;
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart'
    as _i270;
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart'
    as _i829;
import 'package:lifecoach/application_services/repositories/chat_repository_impl.dart'
    as _i518;
import 'package:lifecoach/application_services/repositories/goals_repository_impl.dart'
    as _i500;
import 'package:lifecoach/application_services/repositories/settings_repository_impl.dart'
    as _i767;
import 'package:lifecoach/di/authentication_repository_module.dart' as _i413;
import 'package:lifecoach/di/dio_http_client_module.dart' as _i1000;
import 'package:lifecoach/di/preferences_module.dart' as _i78;
import 'package:lifecoach/di/rest_client_module.dart' as _i868;
import 'package:lifecoach/di/retrofit_http_client_module.dart' as _i696;
import 'package:lifecoach/di/user_repository_module.dart' as _i960;
import 'package:lifecoach/domain_services/chat_repository.dart' as _i737;
import 'package:lifecoach/domain_services/goals_repository.dart' as _i109;
import 'package:lifecoach/domain_services/settings_repository.dart' as _i912;
import 'package:lifecoach/infrastructure/ws/rest/interceptors/logging_interceptor.dart'
    as _i284;
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart'
    as _i1073;
import 'package:models/models.dart' as _i669;
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
    final userRepositoryModule = _$UserRepositoryModule();
    final dioHttpClientModule = _$DioHttpClientModule();
    final restClientModule = _$RestClientModule();
    final retrofitHttpClientModule = _$RetrofitHttpClientModule();
    final authenticationRepositoryModule = _$AuthenticationRepositoryModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i284.LoggingInterceptor>(
        () => const _i284.LoggingInterceptor());
    gh.lazySingleton<_i164.UserRepository>(() =>
        userRepositoryModule.getUserRepository(gh<_i460.SharedPreferences>()));
    gh.factory<_i912.SettingsRepository>(
        () => _i767.SettingsRepositoryImpl(gh<_i460.SharedPreferences>()));
    await gh.factoryAsync<_i361.Dio>(
      () =>
          dioHttpClientModule.getDioHttpClient(gh<_i284.LoggingInterceptor>()),
      preResolve: true,
    );
    gh.lazySingleton<_i669.RestClient>(
        () => restClientModule.getRestClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i1073.RetrofitClient>(
        () => retrofitHttpClientModule.getRetrofitHttpClient(gh<_i361.Dio>()));
    gh.factory<_i109.GoalsRepository>(
        () => _i500.GoalsRepositoryImpl(gh<_i669.RestClient>()));
    gh.lazySingleton<_i223.AuthenticationRepository>(
        () => authenticationRepositoryModule.getAuthenticationRepository(
              gh<_i1073.RetrofitClient>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i737.ChatRepository>(
        () => _i518.ChatRepositoryImpl(gh<_i1073.RetrofitClient>()));
    gh.factory<_i489.ChatBloc>(() => _i489.ChatBloc(
          gh<_i737.ChatRepository>(),
          gh<_i912.SettingsRepository>(),
          gh<_i164.UserRepository>(),
        ));
    gh.factory<_i73.AuthenticationBloc>(() => _i73.AuthenticationBloc(
          authenticationRepository: gh<_i223.AuthenticationRepository>(),
          userRepository: gh<_i164.UserRepository>(),
        ));
    gh.factory<_i270.SignInBloc>(() => _i270.SignInBloc(
        authenticationRepository: gh<_i223.AuthenticationRepository>()));
    gh.factory<_i829.SignUpBloc>(() => _i829.SignUpBloc(
        authenticationRepository: gh<_i223.AuthenticationRepository>()));
    gh.factory<_i989.GoalsBloc>(() => _i989.GoalsBloc(
          gh<_i109.GoalsRepository>(),
          gh<_i73.AuthenticationBloc>(),
        ));
    return this;
  }
}

class _$SharedPreferencesModule extends _i78.SharedPreferencesModule {}

class _$UserRepositoryModule extends _i960.UserRepositoryModule {}

class _$DioHttpClientModule extends _i1000.DioHttpClientModule {}

class _$RestClientModule extends _i868.RestClientModule {}

class _$RetrofitHttpClientModule extends _i696.RetrofitHttpClientModule {}

class _$AuthenticationRepositoryModule
    extends _i413.AuthenticationRepositoryModule {}

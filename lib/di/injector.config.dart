// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lifecoach/di/preferences_module.dart' as _i78;
import 'package:lifecoach/di/retrofit_client_module.dart' as _i1007;
import 'package:lifecoach/infrastructure/ws/rest/logging_interceptor.dart'
    as _i865;
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart'
    as _i1073;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

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
    final retrofitClientModule = _$RetrofitClientModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i865.LoggingInterceptor>(
        () => const _i865.LoggingInterceptor());
    gh.factory<_i1073.RetrofitClient>(() =>
        retrofitClientModule.getRestClient(gh<_i865.LoggingInterceptor>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i78.SharedPreferencesModule {}

class _$RetrofitClientModule extends _i1007.RetrofitClientModule {}

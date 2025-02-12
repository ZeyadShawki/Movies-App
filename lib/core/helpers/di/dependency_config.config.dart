// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies/core/app-preferances/app_preferances.dart' as _i572;
import 'package:movies/core/app-router/app_router.dart' as _i640;
import 'package:movies/core/helpers/di/register_module.dart' as _i309;
import 'package:movies/core/helpers/dio/api_helper.dart' as _i1053;
import 'package:movies/core/helpers/network/network_info.dart' as _i41;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i572.AppPreferences>(() =>
        _i572.AppPreferences(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i1053.ApiHelper>(() => _i1053.ApiHelper());
    gh.singleton<_i41.NetworkInfo>(() => _i41.NetworkInfoImpl());
    gh.lazySingleton<_i640.AppRouter>(() => _i640.AppRouter());
    return this;
  }
}

class _$RegisterModule extends _i309.RegisterModule {}

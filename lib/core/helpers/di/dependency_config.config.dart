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
import 'package:movies/core/app-router/app_router.dart' as _i640;
import 'package:movies/core/helpers/di/register_module.dart' as _i309;
import 'package:movies/core/helpers/dio/api_helper.dart' as _i1053;
import 'package:movies/core/helpers/network/network_info.dart' as _i41;
import 'package:movies/movies/data/remote_data_source/remote_data_source_movie.dart'
    as _i819;
import 'package:movies/movies/data/repostery/movie_repostery.dart' as _i127;
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart'
    as _i212;
import 'package:movies/movies/domain/usecase/get_movie_details_usecase.dart'
    as _i210;
import 'package:movies/movies/domain/usecase/get_nowplaying_movie_usecase.dart'
    as _i215;
import 'package:movies/movies/domain/usecase/get_populer_movie_usecase.dart'
    as _i327;
import 'package:movies/movies/domain/usecase/get_recmonded_movie_usecase.dart'
    as _i639;
import 'package:movies/movies/domain/usecase/get_top_rated_movie_usecase.dart'
    as _i758;
import 'package:movies/movies/domain/usecase/search_for_movie_use_case.dart'
    as _i665;
import 'package:movies/movies/presentation/bloc/movie_bloc/home_moive_bloc.dart'
    as _i437;
import 'package:movies/movies/presentation/bloc/movie_details_cubit/movie_details_cubit.dart'
    as _i60;
import 'package:movies/movies/presentation/bloc/search_cubit/search_for_movie_cubit.dart'
    as _i957;
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
    gh.factory<_i1053.ApiHelper>(() => _i1053.ApiHelper());
    gh.singleton<_i819.BaseMovieRemoteDataSource>(
        () => _i819.MovieRemoteDataSource());
    gh.singleton<_i41.NetworkInfo>(() => _i41.NetworkInfoImpl());
    gh.singleton<_i212.BaseMovieRepostery>(() => _i127.MovieRepostery(
          gh<_i819.BaseMovieRemoteDataSource>(),
          gh<_i41.NetworkInfo>(),
        ));
    gh.singleton<_i210.GetMovieDetailsUseCase>(
        () => _i210.GetMovieDetailsUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.singleton<_i215.GetNowPlayingUseCase>(
        () => _i215.GetNowPlayingUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.singleton<_i758.GetTopRatedUseCase>(
        () => _i758.GetTopRatedUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.singleton<_i639.GetRecommendedMovieUseCase>(
        () => _i639.GetRecommendedMovieUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.singleton<_i327.GetPopularMovieUseCase>(
        () => _i327.GetPopularMovieUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.singleton<_i665.SearchForMovieUseCase>(
        () => _i665.SearchForMovieUseCase(gh<_i212.BaseMovieRepostery>()));
    gh.lazySingleton<_i640.AppRouter>(() => _i640.AppRouter());
    gh.factory<_i60.MovieDetailsCubit>(() => _i60.MovieDetailsCubit(
          gh<_i210.GetMovieDetailsUseCase>(),
          gh<_i639.GetRecommendedMovieUseCase>(),
        ));
    gh.factory<_i957.SearchForMovieCubit>(
        () => _i957.SearchForMovieCubit(gh<_i665.SearchForMovieUseCase>()));
    gh.factory<_i437.HomeMovieBloc>(() => _i437.HomeMovieBloc(
          gh<_i215.GetNowPlayingUseCase>(),
          gh<_i758.GetTopRatedUseCase>(),
          gh<_i327.GetPopularMovieUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i309.RegisterModule {}

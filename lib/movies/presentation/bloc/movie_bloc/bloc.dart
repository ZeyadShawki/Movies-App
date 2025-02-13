import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/enum_movie_state.dart';
import '../../../domain/usecase/get_nowplaying_movie_usecase.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

import '../../../domain/usecase/get_populer_movie_usecase.dart';
import '../../../domain/usecase/get_top_rated_movie_usecase.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;
  MovieBloc(
    this.getNowPlayingUseCase,
    this.getTopRatedUseCase,
    this.getPopularMovieUseCase,
  ) : super(const MovieState()) {
    on<GetNowPlayingEvent>(_getNowPlaying);
    on<GetPopularEvent>(_getPopular);
    on<GetTopRatedEvent>(_getTopRated);
  }

  int nowPlayingPage = 1;
  int popularPage = 1;
  int topRatedPage = 1;

  void _getNowPlaying(
      GetNowPlayingEvent event, Emitter<MovieState> emit) async {
    emit(state.copywith(
      nowPlayingState: RequestState.isLoading,
    ));
    final result = await getNowPlayingUseCase( nowPlayingPage++);

    result.fold((l) {
      emit(state.copywith(
        nowPlayingState: RequestState.isError,
        nowPlayingMessage: l.message,
      ));
    }, (r) {
      emit(state.copywith(
        nowPlayingState: RequestState.isLoaded,
        nowPlayingMovie: [
          ...state.nowPlayingMovie,
          ...r,
        ],
      ));
    });
  }

  void _getPopular(GetPopularEvent event, Emitter<MovieState> emit) async {
    emit(state.copywith(
      popularState: RequestState.isLoading,
    ));

    final result = await getPopularMovieUseCase( popularPage++);

    result.fold((l) {
      emit(state.copywith(
        popularState: RequestState.isError,
        popularMessage: l.message,
      ));
    }, (r) {
      emit(state.copywith(
        popularMovie: [
          ...state.popularMovie,
          ...r,
        ],
        popularState: RequestState.isLoaded,
      ));
    });
  }

  void _getTopRated(GetTopRatedEvent event, Emitter<MovieState> emit) async {
    emit(state.copywith(
      topRatedState: RequestState.isLoading,
    ));
    final result = await getTopRatedUseCase( topRatedPage++);

    result.fold((l) {
      emit(state.copywith(
        topRatedState: RequestState.isError,
        topRatedMessage: l.message,
      ));
    }, (r) {
      emit(state.copywith(
        topRatedMovie: [...state.topRatedMovie, ...r], // Append new results
        topRatedState: RequestState.isLoaded,
      ));
    });
  }
}

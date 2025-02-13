import 'package:equatable/equatable.dart';
import '../../../../core/utils/enum_movie_state.dart';

import '../../../domain/entities/movie.dart';

class HomeMovieState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularState;
  final RequestState topRatedState;

  final List<Movie> nowPlayingMovie;
  final List<Movie> popularMovie;
  final List<Movie> topRatedMovie;

  final String nowPlayingMessage;
  final String popularMessage;
  final String topRatedMessage;

  const HomeMovieState({
    this.nowPlayingState = RequestState.isLoading,
    this.popularState = RequestState.isLoading,
    this.topRatedState = RequestState.isLoading,
    this.nowPlayingMessage = '',
    this.popularMessage = '',
    this.topRatedMessage = '',
    this.nowPlayingMovie = const [],
    this.popularMovie = const [],
    this.topRatedMovie = const [],
  });

  HomeMovieState copywith({
    RequestState? nowPlayingState,
    RequestState? popularState,
    RequestState? topRatedState,
    List<Movie>? nowPlayingMovie,
    List<Movie>? popularMovie,
    List<Movie>? topRatedMovie,
    String? nowPlayingMessage,
    String? popularMessage,
    String? topRatedMessage,
  }) {
    return HomeMovieState(
      nowPlayingMovie: nowPlayingMovie ?? this.nowPlayingMovie,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMessage: popularMessage ?? this.popularMessage,
      popularMovie: popularMovie ?? this.popularMovie,
      popularState: popularState ?? this.popularState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
      topRatedMovie: topRatedMovie ?? this.topRatedMovie,
      topRatedState: topRatedState ?? this.topRatedState,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingState,
        popularState,
        topRatedState,
        nowPlayingMovie,
        popularMovie,
        topRatedMovie,
        nowPlayingMessage,
        popularMessage,
        topRatedMessage,
      ];
}

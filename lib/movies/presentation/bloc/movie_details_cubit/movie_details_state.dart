import 'package:equatable/equatable.dart';
import '../../../domain/entities/recommended_movie.dart';

import '../../../../core/utils/enum_movie_state.dart';
import '../../../domain/entities/movie_details.dart';

class MovieDetailsInitial extends Equatable {
  final RequestState movieDetailstate;
  final MovieDetails movieDetails;
  final String movieDetailsMessage;

  final RequestState recommendedstate;
  final List<RecommendedMovie> recommendedmovieDetails;
  final String recommendedmovieMessage;

  // wish list message success
  final String addtoListMessage;

  const MovieDetailsInitial(
      {this.addtoListMessage = '',
      this.recommendedstate = RequestState.isLoading,
      this.recommendedmovieDetails = const [],
      this.recommendedmovieMessage = '',
      this.movieDetailstate = RequestState.isLoading,
      this.movieDetails = const MovieDetails(
          posterPath: '',
          backDropPath: 'backDropPath',
          id: 0,
          title: 'title',
          overview: 'overview',
          voteAverage: 0,
          releaseDate: 'releaseDate',
          genre: [],
          runtime: 0),
      this.movieDetailsMessage = ''});

  MovieDetailsInitial copWith({
    String? addtoListMessage,
    RequestState? movieDetailstate,
    MovieDetails? movieDetails,
    String? movieDetailsMessage,
    RequestState? recommendedstate,
    List<RecommendedMovie>? recommendedmovieDetails,
    String? recommendedmovieMessage,
  }) {
    return MovieDetailsInitial(
        addtoListMessage: addtoListMessage ?? this.addtoListMessage,
        movieDetailstate: movieDetailstate ?? this.movieDetailstate,
        movieDetails: movieDetails ?? this.movieDetails,
        movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
        recommendedstate: recommendedstate ?? this.recommendedstate,
        recommendedmovieDetails:
            recommendedmovieDetails ?? this.recommendedmovieDetails,
        recommendedmovieMessage:
            recommendedmovieMessage ?? this.recommendedmovieMessage);
  }

  @override
  List<Object> get props => [
        movieDetailstate,
        movieDetails,
        movieDetailsMessage,
        recommendedstate,
        recommendedmovieDetails,
        recommendedmovieMessage,
        addtoListMessage,
      ];
}

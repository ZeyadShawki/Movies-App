import 'package:equatable/equatable.dart';

import 'genre.dart';

class MovieDetails extends Equatable {
  final String? backDropPath;
  final String posterPath;
  final int id;
  final String title;
  final String overview;
  final num voteAverage;
  final String releaseDate;
  final List<Genre> genre;
  final int runtime;

  const MovieDetails({
     this.backDropPath,
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.genre,
    required this.runtime,
    required this.posterPath,
  });

  @override
  List<Object> get props => [
        runtime,
        id,
        title,
        overview,
        voteAverage,
        releaseDate,
        genre,
        posterPath
      ];
}

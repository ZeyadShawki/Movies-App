import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int? id;
  final String? title;
  final String? backdropPath;
  final List<int>? genreIds;
  final String? overview;
  final num? voteAverage;
  final String? releaseDate;
  final String? posterPath;

  const Movie({
      this.id,
      this.title,
      this.backdropPath,
      this.genreIds,
      this.overview,
      this.voteAverage,
      this.releaseDate,
      this.posterPath

  });

  @override
  List<Object?> get props =>
      [
    id,
    title,
    backdropPath,
    genreIds,
    overview,
    voteAverage,
    releaseDate,
    posterPath
  ];



}
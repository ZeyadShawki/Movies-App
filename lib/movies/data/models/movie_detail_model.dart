
import 'package:movies/movies/data/models/genres_model.dart';
import 'package:movies/movies/domain/entities/genre.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel(
      {required super.backDropPath,
      required super.id,
      required super.title,
      required super.overview,
      required super.voteAverage,
      required super.releaseDate,
      required super.genre,
      required super.runtime,
        required super.posterPath,
      });

  factory MovieDetailsModel.fromJson(Map<String,dynamic> json)=>
      MovieDetailsModel(
          posterPath: json['poster_path'],
          backDropPath: json['backdrop_path'],
          id: json['id'],
          title: json['original_title'],
          overview: json['overview'],
          voteAverage: json['vote_average'],
          releaseDate: json['release_date'],
          genre: List<Genre>.from(json['genres'].map((e) => GenresModel.fromJson(e))),
          runtime: json['runtime']);

}

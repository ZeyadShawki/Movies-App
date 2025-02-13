
import 'package:movies/movies/domain/entities/recommended_movie.dart';

class RecommendedMovieModel extends RecommendedMovie {
  const RecommendedMovieModel(
      { required super.overview,
      required super.title,
      required super.id,
       super.backdropPath,
        required super.posterPath,
      });

  factory RecommendedMovieModel.fromJson(Map<String,dynamic>json)=>
      RecommendedMovieModel(
          overview: json['overview'],
          title: json['title'],
          id: json['id'],
          backdropPath: json['backdrop_path']??"",
          posterPath: json['poster_path']??"",
      );

}

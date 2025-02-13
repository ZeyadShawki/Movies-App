import 'package:dartz/dartz.dart';
import '../../../core/helpers/error/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/recommended_movie.dart';

abstract class BaseMovieRepostery {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(int? page);
  Future<Either<Failure, List<Movie>>> getPopularMovies(int? page);
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int? page);
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id);
  Future<Either<Failure, List<RecommendedMovie>>> getMovieRecommondation(
      int id);
  Future<Either<Failure, List<Movie>>> searchForMovie(
      {required Map<String, dynamic> query});
}

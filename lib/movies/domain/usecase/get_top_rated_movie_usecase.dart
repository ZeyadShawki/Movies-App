import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';


class GetTopRatedUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetTopRatedUseCase(this.baseMovieRepostery);
  Future<Either<Failure,List<Movie>>> execute()async{
    return await baseMovieRepostery.getTopRatedMovies();
  }
}
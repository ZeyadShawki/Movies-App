import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';

 class SearchForMovieUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  SearchForMovieUseCase(this.baseMovieRepostery);

  Future<Either<Failure,List<Movie>>> execute(String query)async{
    return await baseMovieRepostery.searchForMovie(query);
}
}
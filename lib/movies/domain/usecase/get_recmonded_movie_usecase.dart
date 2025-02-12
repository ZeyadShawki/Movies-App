import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/recommended_movie.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';

class GetRecommendedMovieUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetRecommendedMovieUseCase(this.baseMovieRepostery);

  Future<Either<Failure,List<RecommendedMovie>>> execute(int id)async {
       return await baseMovieRepostery.getMovieRecommondation(id);
  }

}
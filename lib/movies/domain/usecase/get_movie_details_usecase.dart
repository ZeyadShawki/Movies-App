import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';

class GetMovieDetailsUseCase{

  final BaseMovieRepostery baseMovieRepostery;

  GetMovieDetailsUseCase(this.baseMovieRepostery);

  Future<Either<Failure,MovieDetails>> excute(int id)async{
    return await baseMovieRepostery.getMovieDetails(id);
  }
}
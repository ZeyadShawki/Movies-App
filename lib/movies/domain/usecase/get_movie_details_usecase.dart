import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:injectable/injectable.dart' as injectable;

@injectable.Order(-1)
@injectable.singleton
class GetMovieDetailsUseCase{

  final BaseMovieRepostery baseMovieRepostery;

  GetMovieDetailsUseCase(this.baseMovieRepostery);

  Future<Either<Failure,MovieDetails>> excute(int id)async{
    return await baseMovieRepostery.getMovieDetails(id);
  }
}
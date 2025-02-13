import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';
import 'package:injectable/injectable.dart' as injectable;

@injectable.Order(-1)
@injectable.singleton
class GetNowPlayingUseCase{
  final BaseMovieRepostery baseMovieRepostery;

  GetNowPlayingUseCase(this.baseMovieRepostery);
  Future<Either<Failure,List<Movie>>> execute({required int? page})async{
    return await baseMovieRepostery.getNowPlayingMovies(page);
  }
}
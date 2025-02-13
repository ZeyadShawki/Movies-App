import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/usecase/base_usecase.dart';
import '../../../core/helpers/error/failure.dart';
import '../entities/movie.dart';
import '../reposetry/base_movie_repostery.dart';
import 'package:injectable/injectable.dart' as injectable;

@injectable.Order(-1)
@injectable.singleton
class GetPopularMovieUseCase     extends BaseUseCase<List<Movie>, int> {
  final BaseMovieRepostery baseMovieRepostery;

  GetPopularMovieUseCase(this.baseMovieRepostery);
  @override
  Future<Either<Failure, List<Movie>>> call( int? parameters) async {
    return await baseMovieRepostery.getPopularMovies(parameters);
  }
}

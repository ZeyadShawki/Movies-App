import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:movies/core/helpers/usecase/base_usecase.dart';

import '../../../core/helpers/error/failure.dart';
import '../entities/movie_details.dart';
import '../reposetry/base_movie_repostery.dart';

@injectable.Order(-2)
@injectable.singleton
class GetMovieDetailsUseCase extends BaseUseCase<MovieDetails, int> {
  final BaseMovieRepostery baseMovieRepostery;

  GetMovieDetailsUseCase(this.baseMovieRepostery);

  @override
  Future<Either<Failure, MovieDetails>> call(int parameters) async {
    return await baseMovieRepostery.getMovieDetails(parameters);
  }
}

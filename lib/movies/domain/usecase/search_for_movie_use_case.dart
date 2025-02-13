import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:movies/core/helpers/usecase/base_usecase.dart';

import '../../../core/helpers/error/failure.dart';
import '../entities/movie.dart';
import '../reposetry/base_movie_repostery.dart';

@injectable.Order(-1)
@injectable.singleton
class SearchForMovieUseCase
    extends BaseUseCase<List<Movie>, Map<String, dynamic>> {
  final BaseMovieRepostery baseMovieRepostery;

  SearchForMovieUseCase(this.baseMovieRepostery);

  @override
  Future<Either<Failure, List<Movie>>> call(
      Map<String, dynamic> parameters) async {
    return await baseMovieRepostery.searchForMovie(
      query: parameters,
    );
  }
}

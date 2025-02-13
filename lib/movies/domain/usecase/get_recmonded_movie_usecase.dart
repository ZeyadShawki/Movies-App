import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/usecase/base_usecase.dart';
import '../../../core/helpers/error/failure.dart';
import '../entities/recommended_movie.dart';
import '../reposetry/base_movie_repostery.dart';
import 'package:injectable/injectable.dart' as injectable;

@injectable.Order(-1)
@injectable.singleton
class GetRecommendedMovieUseCase   extends BaseUseCase<List<RecommendedMovie>, int>  {
  final BaseMovieRepostery baseMovieRepostery;

  GetRecommendedMovieUseCase(this.baseMovieRepostery);

  @override
  Future<Either<Failure, List<RecommendedMovie>>> call(int parameters) async {
    return await baseMovieRepostery.getMovieRecommondation(parameters);
  }
}

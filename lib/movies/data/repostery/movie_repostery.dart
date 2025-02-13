import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/core/helpers/error/server_exception.dart';
import 'package:movies/core/helpers/network/network_info.dart';
import 'package:movies/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/entities/recommended_movie.dart';

import 'package:injectable/injectable.dart' as injectable;
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';

@injectable.Order(-2)
@injectable.Singleton(as: BaseMovieRepostery)
class MovieRepostery extends BaseMovieRepostery {
  final BaseMovieRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;
  MovieRepostery(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(int? page) async {
    final result = await remoteDataSource.getNowPlayingMovie(page);
    if (await _networkInfo.isConnected) {
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int? page) async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getPopularMovie(page);
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int? page) async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getTopRatedMovie(page);
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id) async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getMovieDetails(id);
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<Failure, List<RecommendedMovie>>> getMovieRecommondation(
      int id) async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getRecommendedMovie(id);
      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchForMovie( {required Map<String,dynamic> query})async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.searchForMovie(query: query);

      try {
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure.fromServerException(failure));
      }
    } else {
      return Left(ServerFailure.noInternetConnection());
    }
  }
}

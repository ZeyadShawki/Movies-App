import 'package:dartz/dartz.dart';
import 'package:movies/core/helpers/error/failure.dart';
import 'package:movies/core/helpers/error/server_exception.dart';
import 'package:movies/movies/data/remote_data_source/remote_data_source_movie.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/entities/recommended_movie.dart';
import 'package:movies/movies/domain/reposetry/base_movie_repostery.dart';

import '../../../core/network/network_info.dart';

class MovieRepostery extends BaseMovieRepostery {
  final BaseMovieRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;
  MovieRepostery(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await remoteDataSource.getNowPlayingMovie();
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
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getPopularMovie();
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
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.getTopRatedMovie();
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
  Future<Either<Failure, List<Movie>>> searchForMovie(String query) async {
    if (await _networkInfo.isConnected) {
      final result = await remoteDataSource.searchForMovie(query);

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

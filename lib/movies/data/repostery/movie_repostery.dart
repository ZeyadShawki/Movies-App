import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../../core/helpers/error/failure.dart';
import '../../../core/helpers/network/network_info.dart';
import '../remote_data_source/remote_data_source_movie.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommended_movie.dart';

import 'package:injectable/injectable.dart' as injectable;
import '../../domain/reposetry/base_movie_repostery.dart';

@injectable.Order(-2)
@injectable.Singleton(as: BaseMovieRepostery)
class MovieRepostery extends BaseMovieRepostery {
  final BaseMovieRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;
  MovieRepostery(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(int? page) async {
   
    if (await _networkInfo.isConnected) {
      try {
            final result = await remoteDataSource.getNowPlayingMovie(page);

        return Right(result);
      } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int? page) async {
    if (await _networkInfo.isConnected) {
      try {
              final result = await remoteDataSource.getPopularMovie(page);

        return Right(result);
    } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int? page) async {
    if (await _networkInfo.isConnected) {
      try {
              final result = await remoteDataSource.getTopRatedMovie(page);

        return Right(result);
    } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id) async {
   
    if (await _networkInfo.isConnected) {
      try {
              final result = await remoteDataSource.getMovieDetails(id);

        return Right(result);
    } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<RecommendedMovie>>> getMovieRecommondation(
      int id) async {
    if (await _networkInfo.isConnected) {
      try {
              final result = await remoteDataSource.getRecommendedMovie(id);

        return Right(result);
    } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchForMovie(
      {required Map<String, dynamic> query}) async {
    if (await _networkInfo.isConnected) {

      try {
              final result = await remoteDataSource.searchForMovie(query: query);

        return Right(result);
    } on ServerFailure catch (failure) {
        log('ssss');
        return Left(ServerFailure(message:  failure.message));
      }
    } else {
        return Left(ServerFailure(message:  noInternetConnection));
    }
  }
}

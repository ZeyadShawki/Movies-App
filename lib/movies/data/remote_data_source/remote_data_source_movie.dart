import 'package:injectable/injectable.dart' as injectable;

import '../../../core/helpers/dio/api_helper.dart';
import '../../../core/network/api_constants.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommended_movie.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/recommended_movie_model.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<Movie>> getNowPlayingMovie(int? page);
  Future<List<Movie>> getPopularMovie(int? page);
  Future<List<Movie>> getTopRatedMovie(int? page);
  Future<MovieDetails> getMovieDetails(int id);
  Future<List<RecommendedMovie>> getRecommendedMovie(int id);
  Future<List<Movie>> searchForMovie({required Map<String, dynamic> query});
}

@injectable.Order(-3)
@injectable.Singleton(as: BaseMovieRemoteDataSource)
class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
 @override
Future<List<MovieModel>> getNowPlayingMovie(int? page) async {

    final response = await ApiHelper().get(
      path: ApiConstants.nowPlayingUrl,
      queryParameters: {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
        'with_release_type': '2|3',
      },
    );

    return response.fold(
      (left) {
        throw left;
      },
      (right) {
        return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)),
        );
      },
    );
 
}


  @override
  Future<List<MovieModel>> getPopularMovie(int? page) async {
    final response = await ApiHelper().get(
      path: ApiConstants.popularUrl,
      queryParameters: {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
        'release_date.gte': '2023-1-1',
        'release_date.lte': ' 2024-12-30',
        'with_release_type': '2|3',
      },
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    });
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie(int? page) async {
    final response = await ApiHelper().get(
      path: ApiConstants.topRatedUrl,
      queryParameters: {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
      },
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    });
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int id) async {
    final response = await ApiHelper().get(
      path: ApiConstants().movieDetailsPathMaker(id),
      queryParameters: {
        'language': 'en-US',
      },
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return MovieDetailsModel.fromJson(right.data);
    });
  }

  @override
  Future<List<RecommendedMovieModel>> getRecommendedMovie(int id) async {
    final response = await ApiHelper().get(
      path: ApiConstants().movieRecemondationPathMaker(id),
      queryParameters: {
        'language': 'en-US',
      },
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<RecommendedMovieModel>.from((right.data['results'] as List)
          .map((e) => RecommendedMovieModel.fromJson(e)));
    });
  }

  @override
  Future<List<MovieModel>> searchForMovie(
      {required Map<String, dynamic> query}) async {
    final response = await ApiHelper().get(
        path: ApiConstants.searchForQueryPathMaker,
        queryParameters: {'language': 'en-US', ...query});

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    });
  }
}

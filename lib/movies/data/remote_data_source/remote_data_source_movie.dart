import 'package:movies/core/helpers/dio/api_helper.dart';
import 'package:movies/core/network/api_constants.dart';
import 'package:movies/movies/data/models/movie_detail_model.dart';
import 'package:movies/movies/data/models/movie_model.dart';
import 'package:movies/movies/data/models/recommended_movie_model.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_details.dart';
import 'package:movies/movies/domain/entities/recommended_movie.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<Movie>> getNowPlayingMovie();
  Future<List<Movie>> getPopularMovie();
  Future<List<Movie>> getTopRatedMovie();
  Future<MovieDetails> getMovieDetails(int id);
  Future<List<RecommendedMovie>> getRecommendedMovie(int id);
  Future<List<Movie>> searchForMovie(String query);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    final response = await ApiHelper().get(
      path: ApiConstants.getNowPlayingUrl,
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    });
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await ApiHelper().get(
      path: ApiConstants.getPopularUrl,
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<MovieModel>.from(
          (right.data['results'] as List).map((e) => MovieModel.fromJson(e)));
    });
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final response = await ApiHelper().get(
      path: ApiConstants.getTopRatedUrl,
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
    );

    return response.fold((left) {
      throw left;
    }, (right) {
      return MovieDetailsModel.fromJson(right.data);
    });
  }

  @override
  Future<List<RecommendedMovieModel>> getRecommendedMovie(int id) async {
    final response = await ApiHelper()
        .get(path: ApiConstants().movieRecemondationPathMaker(id));

    return response.fold((left) {
      throw left;
    }, (right) {
      return List<RecommendedMovieModel>.from((right.data['results'] as List)
          .map((e) => RecommendedMovieModel.fromJson(e)));
    });
  }

  @override
  Future<List<MovieModel>> searchForMovie(String query) async {

       final response = await ApiHelper()
        .get(path: ApiConstants().searchForQueryPathMaker(query));

    return response.fold((left) {
      throw left;
    }, (right) {
        return List<MovieModel>.from((right.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    });
  }
}

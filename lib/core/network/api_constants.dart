class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String discoverUrl = '$baseUrl/discover/movie';
  static const String nowPlayingUrl = discoverUrl;
  static const String popularUrl = discoverUrl;
  static const String topRatedUrl = '$baseUrl/movie/top_rated';

  static const String networkImagePath = 'https://image.tmdb.org/t/p/w500';

  String networkimagemaker(String? path) {
    return '$networkImagePath$path';
  }

  static const String getMovieDetails = '$baseUrl/438148';

  String movieDetailsPathMaker(int id) {
    return '$baseUrl/movie/$id';
  }

  String movieRecemondationPathMaker(int id) {
    return '$baseUrl/movie/$id/recommendations';
  }

  static const String searchForQueryPathMaker = '$baseUrl/search/movie';
}

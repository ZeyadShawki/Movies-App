class ApiConstants{
  static const String baseUrl='https://api.themoviedb.org/3';


  static const String getNowPlayingUrl='$baseUrl/now_playing';
  static const String getPopularUrl='$baseUrl/popular';
  static const String getTopRatedUrl='$baseUrl/top_rated';
  static const String networkImagePath='https://image.tmdb.org/t/p/w500';

  String networkimagemaker(String? path){
    return '$networkImagePath$path';
  }

  static const String getMovieDetails='$baseUrl/438148';

  String movieDetailsPathMaker(int id)
  {
    return '$baseUrl/$id';
  }

  String movieRecemondationPathMaker(int id)
  {
    return '$baseUrl/$id/recommendations';
  }

  String searchForQueryPathMaker(String query)
  {
    return '$baseUrl/search/movie&language=en-US&query=$query';
  }

}
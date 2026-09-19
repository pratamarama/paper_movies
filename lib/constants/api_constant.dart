/// Created by Pratama Ramadhan on 18/09/26.

class ApiConstant {
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String imageBaseUrl = 'https://image.tmdb.org';
  static const String version = '3';
}

enum APIEndpoint {
  discoverMovie('/discover/movie')
  ;

  final String url;
  const APIEndpoint(this.url);

  String get fullPath {
    return '/${ApiConstant.version}/$url';
  }
}

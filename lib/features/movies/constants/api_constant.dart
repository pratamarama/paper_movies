/// Created by Pratama Ramadhan on 18/09/26.

class ApiConstant {
  static const String baseUrl = 'https://api.themoviedb.org/3';
}

enum APIEndpoint {
  discoverMovie('/discover/movie')
  ;

  final String url;
  const APIEndpoint(this.url);
}

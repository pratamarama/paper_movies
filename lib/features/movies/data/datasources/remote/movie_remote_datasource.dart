import 'package:dio/dio.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/api_service.dart';
import 'package:paper_movies/features/movies/data/models/list_response_model.dart';
import 'package:paper_movies/features/movies/data/models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<ListResponseModel<MovieModel>?> getMovieList({required int page, Function(int, int)? onReceiveProgress});
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final ApiService _apiService;

  const MovieRemoteDatasourceImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<ListResponseModel<MovieModel>?> getMovieList({
    required int page,
    Function(int, int)? onReceiveProgress,
  }) async {
    final Response<Map<String, dynamic>> response = await _apiService.getMovieList(page: page);

    final Map<String, dynamic>? data = response.data;
    if (data == null) {
      throw 'Data not found';
    }

    final ListResponseModel<MovieModel> responseModel = ListResponseModel<MovieModel>.fromJson(
      data,
      (Object? json) => MovieModel.fromJson(json! as Map<String, dynamic>),
    );

    return responseModel;
  }
}

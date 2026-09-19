import 'package:dio/dio.dart';
import 'package:paper_movies/constants/api_constant.dart';
import 'package:paper_movies/enums/app_error.dart';

/// Created by Pratama Ramadhan on 18/09/26.

abstract class ApiService {
  Future<Response<Map<String, dynamic>>> getMovieList({required int page, Function(int, int)? onReceiveProgress});
}

class ApiServiceImpl implements ApiService {
  final Dio _dioClient;

  ApiServiceImpl({required Dio dioClient}) : _dioClient = dioClient;

  @override
  Future<Response<Map<String, dynamic>>> getMovieList({
    required int page,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await _dioClient.get(
        APIEndpoint.discoverMovie.fullPath,
        queryParameters: <String, dynamic>{
          'include_adult': false,
          'include_video': false,
          'language': 'en-US',
          'page': page,
          'sort_by': 'popularity.desc',
        },
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioException catch (e) {
      throw AppError<String>.connectionError(e.message ?? 'Connection Error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:paper_movies/features/movies/constants/api_constant.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/json_response_interceptor.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/main_dio_interceptor.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(baseUrl: ApiConstant.baseUrl),
    )..interceptors.addAll(<Interceptor>[JsonResponseInterceptor(), MainDioInterceptor()]);
  }

  Dio get dio => _dio;
}

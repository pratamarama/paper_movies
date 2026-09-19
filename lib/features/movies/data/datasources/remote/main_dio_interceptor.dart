import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_movies/enums/app_error.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class MainDioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    const String apiKey = String.fromEnvironment('API_KEY');
    options.queryParameters.addAll(<String, dynamic>{'api_key': apiKey});

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException error, ErrorInterceptorHandler handler) async {
    String message = '';
    debugPrint('Dio Error: ${error.response}');

    switch (error.response?.statusCode) {
      case 401:
        message = 'Session has expired';
      case 403:
        message = 'No access';
      case 404:
        message = 'Not Found';
      case 500:
        message = 'Server Error';
    }

    try {
      final Map<String, dynamic>? responseJson = error.response?.data as Map<String, dynamic>?;
      final String? responseMessage = responseJson?['status_message'] as String?;
      message = responseMessage ?? message;
    } catch (e) {
      debugPrint('Parsing error: $e');
    }

    if (message.isNotEmpty) {
      return handler.next(error.copyWith(error: AppError<String>.connectionError(message)));
    }

    return handler.next(error);
  }
}

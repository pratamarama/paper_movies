import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

    if (message.isNotEmpty) {
      return handler.next(error.copyWith(message: message));
    }

    return handler.next(error);
  }
}

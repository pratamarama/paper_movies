import 'dart:convert';

import 'package:dio/dio.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class JsonResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final dynamic data = response.data;
    if (data is String) {
      response.data = json.decode(data);
    }

    super.onResponse(response, handler);
  }
}

// ignore: file_names
import 'dart:convert';
import 'package:dio/dio.dart';

enum Method { POST, GET, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  Future<HttpService> init(BaseOptions options) async {
    _dio = Dio(options);
    return this;
  }

  request(
      {required String endpoint,
      required Method method,
      Map<String, dynamic>? params,
      Map<String, dynamic>? queryParams}) async {
    Response response;

    try {
      //convert to switch case
      if (method == Method.GET) {
        response = await _dio!.get(endpoint,
            queryParameters: queryParams, data: json.encode(params));
      } else if (method == Method.POST) {
        response = await _dio!.post(endpoint, data: json.encode(params));
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(endpoint);
      } else {
        response = await _dio!.patch(endpoint, data: json.encode(params));
      }
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}

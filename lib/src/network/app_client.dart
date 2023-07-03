import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:dio/dio.dart';

class AppClient {
  late Dio _dio;

  AppClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: FlavorConfig.instance.variables['baseUrl'],
        headers: {
          'Authorization':
              'Bearer ${FlavorConfig.instance.variables['apiKey']}',
        },
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

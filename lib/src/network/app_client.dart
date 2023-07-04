import 'package:dio/dio.dart';

class AppClient {
  late Dio dio;
  final String baseUrl;
  final String apiKey;

  AppClient({
    required this.baseUrl,
    required this.apiKey,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient(baseUrl: " ");
});

class ApiClient {
  final Dio _dio;
  String? _authToken;

  ApiClient({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
        ),
      );

  set authToken(String? token) {
    _authToken = token;
  }

  Future<Response> get(String path) async {
    return _dio.get(
      path,
      options: Options(
        headers: _authToken != null
            ? {'Authorization': 'Bearer $_authToken'}
            : {},
      ),
    );
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(
      path,
      data: data,
      options: Options(
        headers: _authToken != null
            ? {'Authorization': 'Bearer $_authToken'}
            : {},
      ),
    );
  }
}

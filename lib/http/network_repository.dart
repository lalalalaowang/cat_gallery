import 'package:cat_gallery/model/api.dart';
import 'package:cat_gallery/model/dog_image.dart';
import 'package:dio/dio.dart';

class NetworkRepository {
  final Dio _dio;
  static final _instance = NetworkRepository._();

  NetworkRepository._() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  factory NetworkRepository() {
    return _instance;
  }

  Future<List<DogImage>> searchImages({required int limit}) async {
    final response = await _dio.get(
      search,
      queryParameters: {"limit": limit},
      options: Options(headers: {
        "x-api-key": apiKey,
        "Content-type": "application/json",
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> result = response.data ?? [];
      return result
          .map((e) => DogImage.formJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}

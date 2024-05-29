import 'package:cat_gallery/model/api.dart';
import 'package:cat_gallery/model/breed.dart';
import 'package:cat_gallery/model/cat_image.dart';
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

  Future<List<CatImage>> searchImages({required int limit}) async {
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
          .map((e) => CatImage.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<bool> addToFavorites({required String imgId}) async {
    final response = await _dio.post(
      favorate,
      data: {"image_id": imgId},
      options: Options(headers: {
        "x-api-key": apiKey,
        "Content-type": "application/json",
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> voteImg({required String imgId, required bool value}) async {
    final response = await _dio.post(
      votes,
      data: {
        "image_id": imgId,
        "value": value ? 1 : 0,
      },
      options: Options(headers: {
        "x-api-key": apiKey,
        "Content-type": "application/json",
      }),
    );
    return response.statusCode == 201;
  }

  Future<List<Breed>> getBreeds({required int limit, required int page}) async {
    final response = await _dio.get(breeds,
        queryParameters: {
          "limit": limit,
          "page": page,
        },
        options: Options(headers: {
          "x-api-key": apiKey,
          "Content-type": "application/json"
        }));
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data ?? [];
      return list
          .map((e) => Breed.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}

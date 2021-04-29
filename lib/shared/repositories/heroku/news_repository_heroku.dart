import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/shared/repositories/abstract/news_repository.dart';
import 'package:sports_news/shared/repositories/heroku/base_endpoint.dart';

class NewsRepositoryHeroku implements NewsRepository {
  NewsRepositoryHeroku({@required this.auth}) {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseEndpointHeroku().baseEndpoint,
        headers: <String, dynamic>{'Authorization': 'Bearer ' + auth.token},
      ),
    );
  }

  final Auth auth;
  Dio dio;

  @override
  Future<Map<String, dynamic>> getHighlights() async {
    final Response<Map<String, dynamic>> result = await dio.get(
      '/v1/client/news/highlights',
    );

    return result.statusCode == 200 ? result.data : null;
  }

  @override
  Future<Map<String, dynamic>> getNews({
    int currentPage = 1,
    int perPage = 20,
    String publishedAt,
  }) async {
    final Response<Map<String, dynamic>> result = await dio.get(
      '/v1/client/news',
      queryParameters: <String, dynamic>{
        'current_page': currentPage,
        'per_page': perPage,
        'published_at': publishedAt,
      },
    );

    return result.statusCode == 200 ? result.data : null;
  }
}

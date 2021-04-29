import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/shared/repositories/abstract/news_repository.dart';
import 'package:sports_news/shared/repositories/news_api/base_endpoint.dart';

/// NEEDS REWORK
class NewsRepositoryNewsApi implements NewsRepository {
  NewsRepositoryNewsApi({@required this.auth}) {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseEndpointNewsApi().baseEndpoint,
        // headers: <String, dynamic>{'Authorization': 'Bearer ' + auth.token},
      ),
    );
  }

  final Auth auth;
  Dio dio;

  @override
  Future<Map<String, dynamic>> getHighlights() async {
    final Response<Map<String, dynamic>> result = await dio.get(
      'top-headlines',
      queryParameters: {
        'country': 'us',
        'category': 'business',
        'apiKey': GetIt.I.get<Auth>().token,
      },
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
      '/everything',
      queryParameters: <String, dynamic>{
        'q': 'tesla',
        'from': '2021-03-29',
        'sortBy': 'publishedAt',
        'apiKey': GetIt.I.get<Auth>().token,
        'pageSize': 60,
      },
      /*
      queryParameters: <String, dynamic>{
        'current_page': currentPage,
        'per_page': perPage,
        'published_at': publishedAt,
      },
      */
    );

    // print(result.data);
    // return result.data;

    return result.statusCode == 200 ? result.data : null;
  }
}

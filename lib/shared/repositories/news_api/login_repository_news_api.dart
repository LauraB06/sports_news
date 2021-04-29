import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/shared/repositories/abstract/login_repository.dart';
import 'package:sports_news/shared/repositories/news_api/base_endpoint.dart';

/// NEEDS REWORK
class LoginRepositoryNewsApi implements LoginRepository {
  LoginRepositoryNewsApi({@required this.auth}) {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseEndpointNewsApi().baseEndpoint,
      ),
    );
  }

  final Auth auth;
  Dio dio;

  @override
  Future<Map<String, dynamic>> signIn({
    @required String email,
    @required String password,
  }) async {
    // final Response<Map<String, dynamic>> result =
        // await dio.post<Map<String, dynamic>>(
      // '/v1/client/auth/signin',
      // data: <String, dynamic>{
        // 'email': email,
        // 'password': password,
      // },
    // );

    return <String, dynamic>{'token': '5c650570de694c32883cd56c9ae86378'};
    // return result.statusCode >= 200 && result.statusCode < 300
        // ? result.data
        // : null;
  }

  @override
  Future<Map<String, dynamic>> signUp({
    @required String email,
    @required String name,
    @required String password,
  }) async {
    // final Response<Map<String, dynamic>> result =
        // await dio.post<Map<String, dynamic>>(
      // '/v1/client/auth/signup',
      // data: <String, dynamic>{
        // 'name': name,
        // 'email': email,
        // 'password': password,
      // },
    // );

    return <String, dynamic>{'token': '5c650570de694c32883cd56c9ae86378'};
    // return result.statusCode >= 200 && result.statusCode < 300
        // ? result.data
        // : null;
  }
}

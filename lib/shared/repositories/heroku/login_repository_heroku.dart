import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/shared/repositories/abstract/login_repository.dart';
import 'package:sports_news/shared/repositories/heroku/base_endpoint.dart';

class LoginRepositoryHeroku implements LoginRepository {
  LoginRepositoryHeroku({@required this.auth}) {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseEndpointHeroku().baseEndpoint,
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
    final Response<Map<String, dynamic>> result =
        await dio.post<Map<String, dynamic>>(
      '/v1/client/auth/signin',
      data: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    return result.statusCode >= 200 && result.statusCode < 300
        ? result.data
        : null;
  }

  @override
  Future<Map<String, dynamic>> signUp({
    @required String email,
    @required String name,
    @required String password,
  }) async {
    final Response<Map<String, dynamic>> result =
        await dio.post<Map<String, dynamic>>(
      '/v1/client/auth/signup',
      data: <String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return result.statusCode >= 200 && result.statusCode < 300
        ? result.data
        : null;
  }
}

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/shared/repositories/abstract/login_repository.dart';

class LoginService {
  LoginService({
    @required this.loginRepository,
  });

  final LoginRepository loginRepository;

  Future<bool> signIn({
    @required String email,
    @required String password,
  }) async {
    final Map<String, dynamic> response = await loginRepository.signIn(
      email: email,
      password: password,
    );

    if (response != null) {
      GetIt.instance
          .get<Auth>()
          .setToken(newToken: response['token'] as String);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    final Map<String, dynamic> response = await loginRepository.signUp(
      name: name,
      email: email,
      password: password,
    );

    if (response != null) {
      GetIt.instance
          .get<Auth>()
          .setToken(newToken: response['token'] as String);
      return true;
    } else {
      return false;
    }
  }
}

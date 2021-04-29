import 'package:flutter/foundation.dart';

abstract class LoginRepository {
  Future<Map<String, dynamic>> signIn({
    @required String email,
    @required String password,
  });

  Future<Map<String, dynamic>> signUp({
    @required String email,
    @required String name,
    @required String password,
  });
}

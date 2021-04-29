import 'package:dio/dio.dart';

class Auth {
  Auth({this.dio});

  final Dio dio;
  String _currentToken;

  String get token {
    return _currentToken ?? '';
  }

  bool setToken({String newToken}) {
    if (newToken != null) {
      print('Setting new token: $newToken');
      _currentToken = newToken;
      return true;
    }
    return false;
  }
}

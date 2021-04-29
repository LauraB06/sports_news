import 'package:flutter/foundation.dart';

abstract class LoginBlocEvent {
  const LoginBlocEvent();
}

class LoginBlocEventLoginWithCredentials extends LoginBlocEvent {
  const LoginBlocEventLoginWithCredentials({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}

class LoginBlocEventSignUp extends LoginBlocEvent {
  const LoginBlocEventSignUp({
    @required this.email,
    @required this.name,
    @required this.password,
    @required this.birthDate,
  });

  final String email;
  final String name;
  final String password;
  final String birthDate;
}

class LoginBlocEnterWithFacebook extends LoginBlocEvent {}

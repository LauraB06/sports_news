import 'package:flutter/foundation.dart';

abstract class LoginBlocState {
  const LoginBlocState();
}

class LoginBlocStateInitial extends LoginBlocState {}

class LoginBlocStateLoading extends LoginBlocState {}

class LoginBlocStateError extends LoginBlocState {
  LoginBlocStateError({@required this.errorCode});

  final String errorCode;
}

class LoginBlocStateSuccess extends LoginBlocState {}

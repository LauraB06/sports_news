import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  const SignInModel({@required this.email, @required this.password})
      : assert(email != null),
        assert(password != null);

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}

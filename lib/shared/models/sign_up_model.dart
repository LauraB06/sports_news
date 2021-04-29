import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sign_in_model.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel extends SignInModel {
  const SignUpModel({
    @required this.name,
    @required String email,
    @required String password,
  }) : super(email: email, password: password);

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  final String name;

  @override
  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

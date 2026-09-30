import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/core/network/model/user_dto.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? message;
  final String? token;
  final UserDto? user;

  LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

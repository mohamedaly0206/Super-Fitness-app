import 'package:super_fitness_app/core/network/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';

part 'register_response_dto.g.dart';

@JsonSerializable()
class RegisterResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;
  @JsonKey(name: "token")
  final String? token;

  RegisterResponseDto({this.message, this.user, this.token});


  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDtoToJson(this);
  RegisterResponseEntity toDomain() => RegisterResponseEntity(
    message: message,
    user: user?.toDomain(),
    token: token,
  );
}

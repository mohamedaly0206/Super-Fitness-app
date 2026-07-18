import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "info")
  String? info;

  ForgetPasswordResponseDto({this.message, this.info});

  factory ForgetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseDtoToJson(this);

  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(message: message ?? '', info: info ?? '');
  }
}

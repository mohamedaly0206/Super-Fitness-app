import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';

part 'verify_reset_code_response.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  @JsonKey(name: "status")
  String? status;

  VerifyResetCodeResponseDto({this.status});

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseDtoToJson(this);

  VerifyResetCodeEntity toEntity() {
    return VerifyResetCodeEntity(status: status ?? '');
  }
}

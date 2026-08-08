import 'package:json_annotation/json_annotation.dart';

part 'logout_response_dto.g.dart';

@JsonSerializable()
class LogoutResponseDto {
  @JsonKey(name: "message")
  String? message;

  LogoutResponseDto({this.message});

  factory LogoutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseDtoToJson(this);
}

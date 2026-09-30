// To parse this JSON data, do
//
//     final uploadProfileImageDto = uploadProfileImageDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';

part 'upload_profile_image_dto.g.dart';

UploadProfileImageDto uploadProfileImageDtoFromJson(String str) =>
    UploadProfileImageDto.fromJson(json.decode(str));

String uploadProfileImageDtoToJson(UploadProfileImageDto data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UploadProfileImageDto {
  @JsonKey(name: "message")
  final String? message;

  UploadProfileImageDto({this.message});

  factory UploadProfileImageDto.fromJson(Map<String, dynamic> json) =>
      _$UploadProfileImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UploadProfileImageDtoToJson(this);
  UploadProfileImageEntity toDomain() {
    return UploadProfileImageEntity(message: message);
  }
}

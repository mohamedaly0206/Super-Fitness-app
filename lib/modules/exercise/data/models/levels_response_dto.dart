import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/data/models/level_dto.dart';

part 'levels_response_dto.g.dart';

@JsonSerializable()
class LevelsResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "levels")
  List<LevelDto>? levels;

  LevelsResponseDto({this.message, this.levels});

  factory LevelsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsResponseDtoToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/data/models/muscle_dto.dart';

part 'muscles_response_dto.g.dart';

@JsonSerializable()
class MusclesResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "totalMuscles")
  int? totalMuscles;

  @JsonKey(name: "muscles")
  List<MuscleDto>? muscles;

  MusclesResponseDto({this.message, this.totalMuscles, this.muscles});

  factory MusclesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MusclesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesResponseDtoToJson(this);
}

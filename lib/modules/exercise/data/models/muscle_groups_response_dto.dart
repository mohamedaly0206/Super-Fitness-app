import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/data/models/muscle_group_dto.dart';

part 'muscle_groups_response_dto.g.dart';

@JsonSerializable()
class MuscleGroupsResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "musclesGroup")
  List<MuscleGroupDto>? musclesGroup;

  MuscleGroupsResponseDto({this.message, this.musclesGroup});

  factory MuscleGroupsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupsResponseDtoToJson(this);
}

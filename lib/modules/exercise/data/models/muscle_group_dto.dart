import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';

part 'muscle_group_dto.g.dart';

@JsonSerializable()
class MuscleGroupDto {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  MuscleGroupDto({this.id, this.name});

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleGroupDtoToJson(this);

  MuscleGroupEntity toEntity() {
    return MuscleGroupEntity(id: id ?? "", name: name ?? "");
  }
}
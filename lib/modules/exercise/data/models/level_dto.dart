import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';

part 'level_dto.g.dart';

@JsonSerializable()
class LevelDto {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  LevelDto({this.id, this.name});

  factory LevelDto.fromJson(Map<String, dynamic> json) =>
      _$LevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDtoToJson(this);

  LevelEntity toEntity() {
    return LevelEntity(id: id ?? "", name: name ?? "");
  }
}

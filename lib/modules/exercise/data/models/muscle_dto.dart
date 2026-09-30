import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';

part 'muscle_dto.g.dart';

@JsonSerializable()
class MuscleDto {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "image")
  String? image;

  MuscleDto({this.id, this.name, this.image});

  factory MuscleDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleDtoToJson(this);

  MuscleEntity toEntity() {
    return MuscleEntity(id: id ?? "", name: name ?? "", image: image ?? "");
  }
}

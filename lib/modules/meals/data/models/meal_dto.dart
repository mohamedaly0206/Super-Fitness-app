import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

part 'meal_dto.g.dart';

@JsonSerializable()
class MealDto {
  @JsonKey(name: "idMeal")
  String? idMeal;

  @JsonKey(name: "strMeal")
  String? strMeal;

  @JsonKey(name: "strMealThumb")
  String? strMealThumb;

  MealDto({this.idMeal, this.strMeal, this.strMealThumb});

  factory MealDto.fromJson(Map<String, dynamic> json) =>
      _$MealDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDtoToJson(this);

  MealEntity toEntity() {
    return MealEntity(
      id: idMeal ?? "",
      name: strMeal ?? "",
      thumbnail: strMealThumb ?? "",
    );
  }
}

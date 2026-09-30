import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/data/models/meal_dto.dart';

part 'meals_response_dto.g.dart';

@JsonSerializable()
class MealsResponseDto {
  @JsonKey(name: "meals")
  List<MealDto>? meals;

  MealsResponseDto({this.meals});

  factory MealsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseDtoToJson(this);
}

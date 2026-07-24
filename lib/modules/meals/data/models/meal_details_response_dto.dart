import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/data/models/meal_details_dto.dart';

part 'meal_details_response_dto.g.dart';

@JsonSerializable()
class MealDetailsResponseDto {
  @JsonKey(name: "meals")
  List<MealDetailsDto>? meals;

  MealDetailsResponseDto({this.meals});

  factory MealDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsResponseDtoToJson(this);
}

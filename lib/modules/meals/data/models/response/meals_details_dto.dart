import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meal_dto.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';

part 'meals_details_dto.g.dart';

@JsonSerializable()
class MealsDetailsDto {
  @JsonKey(name: "meals")
  final List<MealDto>? meals; // Changed from Map to a dedicated DTO

  MealsDetailsDto({this.meals});

  factory MealsDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MealsDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealsDetailsDtoToJson(this);
  
  MealsDetailsEntity toDomain() => MealsDetailsEntity(
        // Map the list of MealDto to a list of MealEntity
        meals: meals?.map((meal) => meal.toDomain()).toList(),
      );
}

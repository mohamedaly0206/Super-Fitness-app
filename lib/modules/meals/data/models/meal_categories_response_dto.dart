import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/data/models/meal_category_dto.dart';

part 'meal_categories_response_dto.g.dart';

@JsonSerializable()
class MealCategoriesResponseDto {
  @JsonKey(name: "categories")
  List<MealCategoryDto>? categories;

  MealCategoriesResponseDto({this.categories});

  factory MealCategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealCategoriesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoriesResponseDtoToJson(this);
}

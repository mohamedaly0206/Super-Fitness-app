import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';

part 'meal_category_dto.g.dart';

@JsonSerializable()
class MealCategoryDto {
  @JsonKey(name: "idCategory")
  String? idCategory;

  @JsonKey(name: "strCategory")
  String? strCategory;

  @JsonKey(name: "strCategoryThumb")
  String? strCategoryThumb;

  @JsonKey(name: "strCategoryDescription")
  String? strCategoryDescription;

  MealCategoryDto({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoryDtoToJson(this);

  MealCategoryEntity toEntity() {
    return MealCategoryEntity(
      id: idCategory ?? "",
      name: strCategory ?? "",
      thumbnail: strCategoryThumb ?? "",
      description: strCategoryDescription ?? "",
    );
  }
}

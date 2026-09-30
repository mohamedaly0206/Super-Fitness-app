import 'package:super_fitness_app/modules/meals/domain/entities/meal_ingredient_entity.dart';

class MealDetailsEntity {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final String source;
  final List<String> tags;
  final List<MealIngredientEntity> ingredients;

  const MealDetailsEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.source,
    required this.tags,
    required this.ingredients,
  });
}

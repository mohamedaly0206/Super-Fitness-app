import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

class MealsDetailsEntity extends Equatable {
  final List<MealEntity>? meals;

  const MealsDetailsEntity({this.meals});

  @override
  List<Object?> get props => [meals];
}

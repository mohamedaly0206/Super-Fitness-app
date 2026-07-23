import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class IngrediEntsWidget extends StatelessWidget {
  IngrediEntsWidget({super.key});
  final ingredients = [
    {'name': 'Meal Breasts', 'amount': '250g'},
    {'name': 'Unsalted Butter', 'amount': '1tbsp'},
    {'name': 'Sesame Or Vegetable Oil', 'amount': '2 Tsp'},
    {'name': 'Fresh Ginger', 'amount': '2 Tsp'},
    {'name': 'Large Eggs', 'amount': '100 G'},
    {'name': 'Large Eggs', 'amount': '100 G'},
    {'name': 'Large Eggs', 'amount': '100 G'},
    {'name': 'Large Eggs', 'amount': '100 G'},
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: List.generate(ingredients.length, (index) {
          final isLast = index == ingredients.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredients[index]['name']!,
                      style: getSemiBoldStyle(
                        context: context,
                        color: theme.colorScheme.onPrimary,
                        fontSize: FontSizeManager.s16,
                      ),
                    ),
                    Text(
                      ingredients[index]['amount']!,
                      style: getRegularStyle(
                        context: context,
                        color: theme.colorScheme.primary,
                        fontSize: FontSizeManager.s12,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
            ],
          );
        }),
      ),
    );
  }
}

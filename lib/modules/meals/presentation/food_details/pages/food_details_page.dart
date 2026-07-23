import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/food_details_top_header.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/ingredients_widget.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodDetailsTopHeader(),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                   AppStrings.ingredients, 
                    style: getBoldStyle(
                      context: context,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: FontSizeManager.s20,
                    )
                  ),
                  const SizedBox(height: AppSize.s8),
                  // REMOVED Expanded() here:
                  IngrediEntsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

class DommyCategory {
  final String title;
  final String image;

  DommyCategory({required this.title, required this.image});
}

final List<DommyCategory> Function(BuildContext) categoriesBuilder =
    (context) => [
          DommyCategory(title: context.gym, image: AppPng.gym),
          DommyCategory(title: context.fitness, image: AppPng.fitness),
          DommyCategory(title: context.yoga, image: AppPng.yoga),
          DommyCategory(title: context.aerobics, image: AppPng.aerobics),
          DommyCategory(title: context.trainer, image: AppPng.training),
        ];

Widget categoryCard({required String title, required String image}) {
  return Column(
    children: [
      Image.asset(image, height: 64, width: 80, fit: BoxFit.contain),
      AppSizedBox(height: 10),
      Text(title),
    ],
  );
}

Widget categoryContainer(Widget child) {
  return Container(
    height: 116,
    padding: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.grey2,
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}
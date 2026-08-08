import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

class DommyCategory {
  final String title;
  final String image;
  final String? url;

  DommyCategory({required this.title, required this.image, this.url});
}

List<DommyCategory> categoriesBuilder(BuildContext context) => [
  DommyCategory(
    title: context.gym,
    image: AppPng.gym,
    url: 'https://en.wikipedia.org/wiki/Gym',
  ),
  DommyCategory(
    title: context.fitness,
    image: AppPng.fitness,
    url: 'https://en.wikipedia.org/wiki/Physical_fitness',
  ),
  DommyCategory(
    title: context.yoga,
    image: AppPng.yoga,
    url: 'https://en.wikipedia.org/wiki/Yoga',
  ),
  DommyCategory(
    title: context.aerobics,
    image: AppPng.aerobics,
    url: 'https://en.wikipedia.org/wiki/Aerobic_exercise',
  ),
  DommyCategory(title: context.trainer, image: AppPng.training),
];

Widget categoryCard({
  required String title,
  required String image,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          image,
          height: AppSize.s64,
          width: AppSize.s80,
          fit: BoxFit.contain,
        ),
        AppSizedBox(height: AppSize.s10),
        Text(title),
      ],
    ),
  );
}

Widget categoryContainer(Widget child) {
  return Container(
    height: AppSize.s116,
    padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
    margin: EdgeInsets.symmetric(horizontal: AppPadding.p8),
    decoration: BoxDecoration(
      color: AppColors.grey2,
      borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
    ),
    child: child,
  );
}

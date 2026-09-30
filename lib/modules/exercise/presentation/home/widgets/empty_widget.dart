import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

Widget emptyWidget(String text) {
  return CustomContainer(
    color: AppColors.borderError,
    height: AppSize.s131,
    width: double.infinity,
    child: Text(
      text,
      style: TextStyle(fontSize: FontSizeManager.s30),
      textAlign: TextAlign.center,
    ),
  );
}

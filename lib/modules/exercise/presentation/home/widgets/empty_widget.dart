import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

Widget emptyWidget(String text) {
  return CustomContainer(
    color: AppColors.borderError,
    height: 131,
    width: double.infinity,
    child: Text(
      text,
      style: TextStyle(fontSize: 30),
      textAlign: TextAlign.center,
    ),
  );
}
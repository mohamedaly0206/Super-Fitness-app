import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

Widget popularTrainingShimmer() {
  return SizedBox(
    height: 200,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: 8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Container(
            width: 250,
            height: 160,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    ),
  );
}
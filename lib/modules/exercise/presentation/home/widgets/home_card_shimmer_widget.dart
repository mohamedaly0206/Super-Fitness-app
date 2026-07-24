import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

Widget homeCardShimmer() {
  return SizedBox(
    height: AppSize.s130,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: AppSize.s8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return AppShimmer(
          child: Container(
            width: AppSize.s120,
            height: AppSize.s130,
            margin: EdgeInsets.all(AppPadding.p4),
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(AppSize.borderRadiusSnackBar),
            ),
          ),
        );
      },
    ),
  );
}
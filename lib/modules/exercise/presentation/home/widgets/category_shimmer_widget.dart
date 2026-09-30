import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

Widget categoryShimmer() {
  return SizedBox(
    height: AppSize.s116,
    child: AppShimmer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: AppSize.s8),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: AppSize.s64,
                  height: AppSize.s64,
                  decoration: BoxDecoration(
                    color: AppColors.grey2,
                    borderRadius: BorderRadius.circular(
                      AppSize.borderRadiusCard,
                    ),
                  ),
                ),
                AppSizedBox(height: AppSize.s10),
                Container(
                  width: AppSize.s50,
                  height: AppSize.s10,
                  decoration: BoxDecoration(
                    color: AppColors.grey2,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

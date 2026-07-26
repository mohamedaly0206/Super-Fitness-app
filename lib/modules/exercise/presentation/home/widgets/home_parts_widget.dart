import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

Widget homeParts({
  required BuildContext context,
  required String title,
  required Widget child,
  Widget? trailing,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: getSemiBoldStyle(
                context: context,
                fontSize: FontSizeManager.s18,
                color: AppColors.textPrimary,
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
      child,
      AppSizedBox(height: AppSize.s10),
    ],
  );
}

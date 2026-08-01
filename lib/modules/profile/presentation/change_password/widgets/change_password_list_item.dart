import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class ChangePasswordListItem extends StatelessWidget {
  final VoidCallback onTap;

  const ChangePasswordListItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p14,
        ),
        decoration: BoxDecoration(
          color: AppColors.glassFill,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusCard),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.change,
              width: AppSize.svgIconSize,
              height: AppSize.svgIconSize,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSize.s12),
            Expanded(
              child: Text(
                context.changePassword,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: AppSize.s14,
              color: AppColors.iconInactive,
            ),
          ],
        ),
      ),
    );
  }
}

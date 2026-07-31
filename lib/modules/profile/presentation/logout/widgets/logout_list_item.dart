import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

class LogoutListItem extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const LogoutListItem({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p14,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.logout,
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
                context.logout,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (isLoading)
              const SizedBox(
                width: AppSize.s16,
                height: AppSize.s16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            else
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

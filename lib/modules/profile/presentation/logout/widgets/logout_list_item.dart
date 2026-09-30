import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class LogoutListItem extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const LogoutListItem({
    super.key,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(AppSize.s20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s16,
          vertical: AppSize.s12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.logout,
              height: AppSize.s22,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSize.s16),
            Expanded(
              child: Text(
                AppStrings.logout,
                style: getSemiBoldStyle(
                  context: context,
                  color: AppColors.primary,
                  fontSize: AppSize.s16,
                ),
              ),
            ),
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

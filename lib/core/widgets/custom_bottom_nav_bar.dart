import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p12,
      ),
      child: GNav(
        selectedIndex: selectedIndex,
        onTabChange: onItemTapped,
        gap: AppSize.s8,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        duration: AppDurations.navBarAnimation,
        color: AppColors.iconInactive,
        activeColor: AppColors.primary,
        tabBackgroundColor: AppColors.primary.withValues(alpha: 0.15),
        backgroundColor: AppColors.transparent,
        tabBorderRadius: AppSize.borderRadiusTab,
        textStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: FontSizeManager.s12,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          GButton(
            icon: Icons.circle,
            leading: _navSvgIcon(AppSvg.home, 0),
            text: AppStrings.home,
          ),
          GButton(
            icon: Icons.circle,
            leading: _navSvgIcon(AppSvg.gym, 1),
            text: AppStrings.workout,
          ),
          GButton(
            icon: Icons.circle,
            leading: _navSvgIcon(AppSvg.chatAi, 2),
            text: AppStrings.chat,
          ),
          GButton(
            icon: Icons.circle,
            leading: _navSvgIcon(AppSvg.profile, 3),
            text: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  Widget _navSvgIcon(String path, int index) {
    final isSelected = selectedIndex == index;
    return SvgPicture.asset(
      path,
      width: AppSize.svgIconSize,
      height: AppSize.svgIconSize,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.primary : AppColors.iconInactive,
        BlendMode.srcIn,
      ),
    );
  }
}

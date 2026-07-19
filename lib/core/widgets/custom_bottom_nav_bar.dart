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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusTab),
          child: GNav(
            tabMargin: const EdgeInsets.symmetric(
              vertical: AppPadding.p8,
              horizontal: AppPadding.p8,
            ),
            selectedIndex: selectedIndex,
            onTabChange: onItemTapped,
            gap: AppSize.s4,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p12,
            ),
            duration: AppDurations.navBarAnimation,
            color: AppColors.iconInactive,
            activeColor: AppColors.primary,
            tabBackgroundColor: Colors.transparent,
            backgroundColor: AppColors.navBarBackground,
            tabBorderRadius: AppSize.borderRadiusTab,
            textStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: FontSizeManager.s12,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              GButton(
                icon: Icons.circle,
                leading: _buildTabContent(AppSvg.home, AppStrings.home, 0),
              ),
              GButton(
                icon: Icons.circle,
                leading: _buildTabContent(AppSvg.gym, AppStrings.workout, 1),
              ),
              GButton(
                icon: Icons.circle,
                leading: _buildTabContent(AppSvg.chatAi, AppStrings.chat, 2),
              ),
              GButton(
                icon: Icons.circle,
                leading: _buildTabContent(AppSvg.profile, AppStrings.profile, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String path, String label, int index) {
    final isSelected = selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          path,
          width: AppSize.svgIconSize,
          height: AppSize.svgIconSize,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.primary : AppColors.iconInactive,
            BlendMode.srcIn,
          ),
        ),
        if (isSelected) ...[
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: FontSizeManager.s12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
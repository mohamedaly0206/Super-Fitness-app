import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool buttonEnable;
  final VoidCallback? onBack;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.buttonEnable = true,
    this.actions,
    this.onBack,
    this.centerTitle = false,
  });

  static const _subtitleHeight = 24.0;

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle == null ? kToolbarHeight : kToolbarHeight + _subtitleHeight,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparent,
      titleSpacing: showBackButton ? AppSize.s0 : AppPadding.p16,
      toolbarHeight: preferredSize.height,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: CustomBackButton(),
            )
          : null,
      title: subtitle == null
          ? _buildTitle(context)
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context),
                Text(
                  subtitle!,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: FontSizeManager.s14,
                  ),
                ),
              ],
            ),
      actions: actions,
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
    title,
    style: getSemiBoldStyle(
      context: context,
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s24,
    ),
  );
}

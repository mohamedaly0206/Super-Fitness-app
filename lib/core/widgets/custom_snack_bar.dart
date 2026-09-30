import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void _show(
    BuildContext context, {
    required String message,
    required Color accentColor,
    required IconData icon,
    Duration? duration,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Container(
            padding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: AppPadding.p4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accentColor, size: AppSize.s20),
                ),
                const SizedBox(width: AppSize.s12),
                Expanded(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    message,
                    style: getMediumStyle(
                      context: context,
                      color: AppColors.textPrimary,
                      fontSize: FontSizeManager.s14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.grey2,
          behavior: SnackBarBehavior.floating,
          duration: duration ?? AppDurations.snackBarDisplay,
          elevation: AppSize.s8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.borderRadiusSnackBar),
            side: BorderSide(
              color: accentColor.withValues(alpha: 0.3),
              width: AppSize.borderWidth,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p16,
          ),
        ),
      );
  }

  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      accentColor: AppColors.success,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      accentColor: AppColors.error,
      icon: Icons.error_rounded,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context,
      message: message,
      accentColor: AppColors.primary,
      icon: Icons.info_rounded,
    );
  }

  static void copied(
    BuildContext context, {
    String message = 'Copied to clipboard',
  }) {
    _show(
      context,
      message: message,
      accentColor: AppColors.textSecondary,
      icon: Icons.copy_rounded,
      duration: const Duration(seconds: 1),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
    );
  }
}

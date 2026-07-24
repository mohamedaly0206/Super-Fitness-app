import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String retryButtonText;

  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.retryButtonText = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: AppSize.s56,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Text(
              'Oops!',
              style: getBoldStyle(
                context: context,
                fontSize: FontSizeManager.s22,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: getMediumStyle(
                context: context,
                fontSize: FontSizeManager.s14,
                color: AppColors.grey800,
              ),
            ),
            const SizedBox(height: AppSize.s28),
            SizedBox(
              width: AppSize.s160,
              height: AppSize.s48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.borderRadiusButton,
                    ),
                  ),
                ),
                onPressed: onRetry,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh_rounded, size: AppSize.s18),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      retryButtonText,
                      style: getMediumStyle(
                        context: context,
                        color: AppColors.textWhite,
                        fontSize: FontSizeManager.s14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

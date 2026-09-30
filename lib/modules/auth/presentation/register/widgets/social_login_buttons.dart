import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onFacebookTap;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final bool isGoogleLoading;
  final bool isFacebookLoading;

  const SocialLoginButtons({
    super.key,
    required this.onFacebookTap,
    required this.onGoogleTap,
    required this.onAppleTap,
    this.isGoogleLoading = false,
    this.isFacebookLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconButton(
          iconAsset: AppSvg.facebook,
          onTap: onFacebookTap,
          isLoading: isFacebookLoading,
        ),
        const AppSizedBox(width: AppSize.s20),
        _SocialIconButton(
          iconAsset: AppSvg.google,
          onTap: onGoogleTap,
          isLoading: isGoogleLoading,
        ),
        const AppSizedBox(width: AppSize.s20),
        _SocialIconButton(iconAsset: AppSvg.apple, onTap: onAppleTap),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback onTap;
  final bool isLoading;

  const _SocialIconButton({
    required this.iconAsset,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: AppSize.s32,
        height: AppSize.s32,
        decoration: const BoxDecoration(
          color: AppColors.grey2,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                width: AppSize.s16,
                height: AppSize.s16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Image.asset(iconAsset, width: AppSize.s20, height: AppSize.s20),
      ),
    );
  }
}

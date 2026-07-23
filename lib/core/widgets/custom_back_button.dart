import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap:
          onBack ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        width: AppSize.s30,
        height: AppSize.s30,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: AppSize.s14,
            height: AppSize.s14,
            child: SvgPicture.asset(AppSvg.backButtonIcon, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

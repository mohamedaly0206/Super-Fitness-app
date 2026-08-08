import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomBackBotton extends StatelessWidget {
  const CustomBackBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      radius: 14,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(AppSvg.back, height: AppSize.s12),
      ),
    );
  }
}

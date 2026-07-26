import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';

class CustomRegisterBackButton extends StatelessWidget {
  const CustomRegisterBackButton({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        if (pageController.page != null && pageController.page! > 0) {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          return;
        }
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
            child: SvgPicture.asset(AppSvg.backIcon, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

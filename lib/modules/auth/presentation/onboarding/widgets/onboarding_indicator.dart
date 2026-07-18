import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const OnboardingIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        expansionFactor: 3,
        dotWidth: 8,
        dotHeight: 8,
        spacing: 6,
        activeDotColor: AppColors.primary,
        dotColor: AppColors.surface.withValues(alpha: .4),
      ),
    );
  }
}

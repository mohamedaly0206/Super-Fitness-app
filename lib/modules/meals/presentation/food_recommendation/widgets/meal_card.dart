import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

class MealCard extends StatelessWidget {
  final MealEntity meal;
  final VoidCallback onTap;

  const MealCard({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusCard),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImageWidget(
              urlToImage: meal.thumbnail,
              width: double.infinity,
              height: double.infinity,
            ),
            // Subtle overall scrim so the card reads as one elegant surface,
            // not just a bright photo with a dark strip at the bottom.
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.grey0.withValues(alpha: 0.15),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparent,
                    AppColors.grey0.withValues(alpha: 0.7),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              left: AppPadding.p8,
              right: AppPadding.p8,
              bottom: AppPadding.p12,
              child: Text(
                meal.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getSemiBoldStyle(
                  context: context,
                  color: AppColors.textWhite,
                  fontSize: FontSizeManager.s16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

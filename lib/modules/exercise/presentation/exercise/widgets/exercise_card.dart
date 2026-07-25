import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/youtube_extension.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseEntity exercise;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,

        padding: const EdgeInsets.all(AppPadding.p4),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s16),
              child: SizedBox(
                width: 90,
                height: 90,
                child: CachedNetworkImageWidget(
                  urlToImage:
                      exercise.shortYoutubeDemonstrationLink.thumbnailUrl,
                ),
              ),
            ),

            const AppSizedBox(width: AppSize.s12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    exercise.exercise,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getBoldStyle(
                      context: context,
                      color: AppColors.textPrimary,
                      fontSize: AppSize.s16,
                    ),
                  ),
                  const AppSizedBox(height: AppSize.s8),
                  Text(
                    exercise.primeMoverMuscle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                      context: context,
                      color: AppColors.textSecondary,
                      fontSize: AppSize.s14,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onPlay,
              icon: const Icon(
                Icons.play_circle_fill_rounded,
                color: AppColors.primary,
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

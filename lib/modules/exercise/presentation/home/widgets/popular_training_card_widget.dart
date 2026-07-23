import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/app_router.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/youtube_thumbnail.dart';

Widget popularTrainingCard({
  required BuildContext context,
  required ExerciseEntity exercise,
}) {
  final thumbnailUrl = youtubeThumbnail(
    exercise.shortYoutubeDemonstrationLink.isNotEmpty
        ? exercise.shortYoutubeDemonstrationLink
        : exercise.inDepthYoutubeExplanationLink,
  );

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        Routes.exerciseDetails,
        arguments: exercise,
      );
    },
    child: Container(
      margin: EdgeInsets.all(4),
      width: 250,
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            thumbnailUrl.isNotEmpty
                ? CachedNetworkImageWidget(
                    urlToImage: thumbnailUrl,
                    width: 120,
                    height: 130,
                  )
                : Container(
                    width: 120,
                    height: 130,
                    color: AppColors.grey2,
                    child: const Icon(Icons.play_circle_outline, size: 48),
                  ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Exercise that',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        exercise.exercise,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          CustomContainer(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            borderRadius: 1000,
                            child: Text(
                              '${exercise.primaryItems} ${exercise.primaryItems > 1 ? "Tasks" : "Task"}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          CustomContainer(
                            alignment: Alignment.center,
                            height: 40,
                            width: 70,
                            borderRadius: 1000,
                            padding: EdgeInsets.zero,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              exercise.difficultyLevel,
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
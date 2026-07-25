import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/extensions/youtube_extension.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/difficulty_selector.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/info_chip.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/show_exercise_video.dart';

import '../cubit/exercise_cubit.dart';

class ExerciseHeader extends StatelessWidget {
  const ExerciseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final exercise = context.select(
      (ExerciseCubit cubit) => cubit.state.selectedExercise,
    );

    if (exercise == null) {
      return const Center(child: Text("Not found!"));
    }

    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          // Image
          CachedNetworkImageWidget(
            urlToImage: exercise.shortYoutubeDemonstrationLink.thumbnailUrl,
            width: double.infinity,
            height: 500,
          ),

          /// Gradient
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.glassShadow, AppColors.grey2],
                  ),
                ),
              ),
            ),
          ),

          /// Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(AppSvg.back, height: 15),
              ),
            ),
          ),

          /// Play Button
          Positioned.fill(
            child: Center(
              child: InkWell(
                onTap: () => showExerciseVideo(context, exercise),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: AppColors.glassShadow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                    size: 42,
                  ),
                ),
              ),
            ),
          ),

          /// العنوان
          Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: Column(
              children: [
                Text(
                  exercise.exercise,
                  style: getMediumStyle(
                    context: context,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const AppSizedBox(height: 8),
                Text(
                  exercise.primeMoverMuscle,
                  style: getRegularStyle(
                    context: context,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          /// Chips
          Positioned(
            left: 12,
            right: 12,
            bottom: 80,
            child: Row(
              children: const [
                InfoChip(text: "30 Min"),
                Spacer(),
                InfoChip(text: "130 Cal", textColor: AppColors.primary),
              ],
            ),
          ),

          /// Difficulty
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DifficultySelector(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/extensions/youtube_extension.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/difficulty_selector.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/info_chip.dart';

import '../cubit/exercise_cubit.dart';

class ExerciseHeader extends StatelessWidget {
  final void Function(ExerciseEntity exercise) onPlayVideo;

  const ExerciseHeader({super.key, required this.onPlayVideo});

  @override
  Widget build(BuildContext context) {
    final exercise = context.select(
      (ExerciseCubit cubit) => cubit.state.selectedExercise,
    );

    if (exercise == null) {
      return const Center(child: Text("Not found!"));
    }

    return SizedBox(
      height: AppSize.s220 * 2,
      child: Stack(
        children: [
          CachedNetworkImageWidget(
            urlToImage: exercise.shortYoutubeDemonstrationLink.thumbnailUrl,
            width: double.infinity,
            height: AppSize.s250 * 2,
          ),

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

          Positioned(
            top: MediaQuery.of(context).padding.top + AppSize.s10,
            left: AppPadding.p16,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(AppSvg.back, height: AppSize.s15),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + AppSize.s10,
            right: AppPadding.p16,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.exerciseDetails,
                  arguments: exercise,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12,
                  vertical: AppPadding.p8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(
                    AppSize.borderRadiusPill,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.textPrimary,
                      size: AppSize.s18,
                    ),
                    const SizedBox(width: AppSize.s4),
                    Text(
                      'Details',
                      style: getMediumStyle(
                        context: context,
                        fontSize: AppSize.s14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Center(
              child: InkWell(
                onTap: () => onPlayVideo(exercise),
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p18),
                  decoration: const BoxDecoration(
                    color: AppColors.glassShadow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                    size: AppSize.s42,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: AppPadding.p20,
            right: AppPadding.p20,
            bottom: AppSize.s100,
            child: Column(
              children: [
                Text(
                  exercise.exercise,
                  style: getMediumStyle(
                    context: context,
                    fontSize: AppSize.s25,
                    color: Colors.white,
                  ),
                ),
                const AppSizedBox(height: AppSize.s8),
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

          Positioned(
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppSize.s80,
            child: Row(
              children: const [
                InfoChip(text: "30 Min"),
                Spacer(),
                InfoChip(text: "130 Cal", textColor: AppColors.primary),
              ],
            ),
          ),

          const Positioned(
            left: AppSize.s0,
            right: AppSize.s0,
            bottom: AppSize.s0,
            child: DifficultySelector(),
          ),
        ],
      ),
    );
  }
}

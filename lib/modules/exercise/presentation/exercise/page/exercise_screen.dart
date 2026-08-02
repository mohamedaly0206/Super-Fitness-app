import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_error_widget.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/cubit/exercise_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_card_shimmer.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_header.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_video_overlay.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercises_list.dart';

import '../cubit/exercise_cubit.dart';

class ExerciseScreen extends StatelessWidget {
  final String primeMoverMuscleId;

  const ExerciseScreen({super.key, required this.primeMoverMuscleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExerciseCubit>()
        ..doEvent(
          LoadExerciseScreenEvent(primeMoverMuscleId: primeMoverMuscleId),
        ),
      child: _ExerciseView(primeMoverMuscleId),
    );
  }
}

class _ExerciseView extends StatefulWidget {
  final String primeMoverMuscleId;

  const _ExerciseView(this.primeMoverMuscleId);

  @override
  State<_ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<_ExerciseView> {
  bool _isVideoPlaying = false;
  ExerciseEntity? _videoExercise;

  void _playVideo(ExerciseEntity exercise) {
    setState(() {
      _isVideoPlaying = true;
      _videoExercise = exercise;
    });
  }

  void _closeVideo() {
    setState(() {
      _isVideoPlaying = false;
      _videoExercise = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseState = context.select(
      (ExerciseCubit cubit) => cubit.state.baseState,
    );
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: Stack(
        children: [
          Builder(
            builder: (_) {
              if (baseState.isLoading) {
                return _buildShimmerLoading();
              }
              if (baseState.errorMessage != null) {
                return AppErrorWidget(
                  errorMessage: baseState.errorMessage!,
                  onRetry: () {
                    context.read<ExerciseCubit>().doEvent(
                      LoadExerciseScreenEvent(
                        primeMoverMuscleId: widget.primeMoverMuscleId,
                      ),
                    );
                  },
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExerciseHeader(onPlayVideo: _playVideo),
                  const AppSizedBox(height: AppSize.s10),
                  Expanded(child: ExercisesList(onPlayVideo: _playVideo)),
                ],
              );
            },
          ),
          if (_isVideoPlaying && _videoExercise != null)
            ExerciseVideoOverlay(
              exercise: _videoExercise!,
              onClose: _closeVideo,
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: AppSize.s220 * 2,
            child: Stack(
              children: [
                const ImageShimmer(
                  width: double.infinity,
                  height: AppSize.s250 * 2,
                ),
                Positioned.fill(
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
                Positioned(
                  left: AppPadding.p20,
                  right: AppPadding.p20,
                  bottom: AppSize.s100,
                  child: Column(
                    children: const [
                      ImageShimmer(
                        width: double.infinity,
                        height: AppSize.s28,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppSize.s8),
                        ),
                      ),
                      SizedBox(height: AppSize.s8),
                      ImageShimmer(
                        width: AppSize.s120,
                        height: AppSize.s16,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppSize.s8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s10),
          ...List.generate(
            5,
            (_) => const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p10,
                vertical: AppPadding.p4,
              ),
              child: ExerciseCardShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_error_widget.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/cubit/exercise_event.dart';
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
              // if (baseState.isLoading) {
              // return  ShimmerLoadingWidget(

              //   );
              // }
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
}

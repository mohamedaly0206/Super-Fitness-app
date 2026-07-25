import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/youtube_extension.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExerciseVideoBottomSheet extends StatefulWidget {
  final ExerciseEntity exercise;

  const ExerciseVideoBottomSheet({super.key, required this.exercise});

  @override
  State<ExerciseVideoBottomSheet> createState() =>
      _ExerciseVideoBottomSheetState();
}

class _ExerciseVideoBottomSheetState extends State<ExerciseVideoBottomSheet> {
  late final YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    controller.loadVideoById(
      videoId: widget.exercise.shortYoutubeDemonstrationLink.youtubeId,
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: AppColors.background,
        child: SizedBox(
          child: YoutubePlayer(controller: controller, aspectRatio: 16 / 9),
        ),
      ),
    );
  }
}

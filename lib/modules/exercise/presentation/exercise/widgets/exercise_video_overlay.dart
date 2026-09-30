import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/youtube_extension.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExerciseVideoOverlay extends StatefulWidget {
  final ExerciseEntity exercise;
  final VoidCallback onClose;

  const ExerciseVideoOverlay({
    super.key,
    required this.exercise,
    required this.onClose,
  });

  @override
  State<ExerciseVideoOverlay> createState() => _ExerciseVideoOverlayState();
}

class _ExerciseVideoOverlayState extends State<ExerciseVideoOverlay> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _controller.loadVideoById(
      videoId: widget.exercise.shortYoutubeDemonstrationLink.youtubeId,
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        color: AppColors.glassShadow.withOpacity(0.8),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(AppSize.s5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: AppSize.s20,
                  spreadRadius: AppSize.s2,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textPrimary,
                      size: AppSize.s28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p4,
                    right: AppPadding.p4,
                    bottom: AppPadding.p10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

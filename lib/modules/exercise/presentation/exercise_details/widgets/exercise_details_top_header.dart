import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseDetailsTopHeader extends StatelessWidget {
  const ExerciseDetailsTopHeader({super.key, required this.exercise});

  final ExerciseEntity exercise;

  String get _videoUrl => exercise.shortYoutubeDemonstrationLink.isNotEmpty
      ? exercise.shortYoutubeDemonstrationLink
      : exercise.inDepthYoutubeExplanationLink ?? '';

  String? get _videoId {
    if (_videoUrl.isEmpty) return null;
    final regExp = RegExp(
      r'(?:youtu\.be\/|youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
      caseSensitive: false,
    );
    return regExp.firstMatch(_videoUrl)?.group(1);
  }

  String? get _thumbnailUrl {
    final id = _videoId;
    if (id == null) return null;
    return 'https://img.youtube.com/vi/$id/mqdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExerciseDetailsCubit>();

    return BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
      builder: (context, state) {
        final isPlaying = state.isPlayingVideo;
        final controller = state.youtubeController;

        return SizedBox(
          height: AppSize.s220,
          width: double.infinity,
          child: Stack(
            children: [
              if (isPlaying && controller != null)
                state.isLoading
                    ? const Center(child: AppLoadingWidget())
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(
                            AppSize.borderRadiusOutlined,
                          ),
                          bottomRight: Radius.circular(
                            AppSize.borderRadiusOutlined,
                          ),
                        ),
                        child: YoutubePlayer(controller: controller),
                      )
              else
                GestureDetector(
                  onTap: () {
                    if (_videoUrl.isNotEmpty) {
                      cubit.doEvent(
                        OpenYoutubeVideoEvent(videoUrl: _videoUrl),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(
                          AppSize.borderRadiusOutlined,
                        ),
                        bottomRight: Radius.circular(
                          AppSize.borderRadiusOutlined,
                        ),
                      ),
                      image: _thumbnailUrl != null
                          ? DecorationImage(
                              image: NetworkImage(_thumbnailUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: _thumbnailUrl == null ? Colors.grey[800] : null,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(
                            AppSize.borderRadiusOutlined,
                          ),
                          bottomRight: Radius.circular(
                            AppSize.borderRadiusOutlined,
                          ),
                        ),
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: AppSize.s64,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

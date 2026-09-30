import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ExerciseYoutubePlayer extends StatefulWidget {
  final String videoId;

  const ExerciseYoutubePlayer({super.key, required this.videoId});

  @override
  State<ExerciseYoutubePlayer> createState() => _ExerciseYoutubePlayerState();
}

class _ExerciseYoutubePlayerState extends State<ExerciseYoutubePlayer> {
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

    controller.loadVideoById(videoId: widget.videoId);
  }

  @override
  void didUpdateWidget(covariant ExerciseYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoId != widget.videoId) {
      controller.loadVideoById(videoId: widget.videoId);
    }
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: controller, aspectRatio: 16 / 9);
  }
}

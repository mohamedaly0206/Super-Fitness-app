import 'package:equatable/equatable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseDetailsState extends Equatable {
  final bool isPlayingVideo;
  final bool isLoading;
  final String? errorMessage;
  final YoutubePlayerController? youtubeController;

  const ExerciseDetailsState({
    this.isPlayingVideo = false,
    this.isLoading = false,
    this.youtubeController,
    this.errorMessage,
  });

  ExerciseDetailsState copyWith({
    bool? isPlayingVideo,
    bool? isLoading,
    String? errorMessage,
    YoutubePlayerController? youtubeController,
  }) {
    return ExerciseDetailsState(
      isPlayingVideo: isPlayingVideo ?? this.isPlayingVideo,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      youtubeController: youtubeController ?? this.youtubeController,
    );
  }

  @override
  List<Object?> get props => [
    isPlayingVideo,
    isLoading,
    errorMessage,
    youtubeController,
  ];
}

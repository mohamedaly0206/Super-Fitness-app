sealed class ExerciseDetailsEvent {}

class OpenYoutubeVideoEvent extends ExerciseDetailsEvent {
  final String videoUrl;
  OpenYoutubeVideoEvent({required this.videoUrl});
}

class CloseYoutubeVideoEvent extends ExerciseDetailsEvent {}

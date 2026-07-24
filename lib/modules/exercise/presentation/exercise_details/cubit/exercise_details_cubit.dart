import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


@Injectable()
class ExerciseDetailsCubit extends Cubit<ExerciseDetailsState> {
  ExerciseDetailsCubit() : super(const ExerciseDetailsState());

  void handleIntent(ExerciseDetailsEvent intent) {
    switch (intent) {
      case OpenYoutubeVideoEvent():
        _openVideo(intent.videoUrl);
        break;
      case CloseYoutubeVideoEvent():
        _closeVideo();
        break;
    }
  }

  void _openVideo(String url) {
    emit(state.copyWith(isLoading: true));

    if (url.isEmpty) {
      emit(state.copyWith(isLoading: false, errorMessage: 'No video available'));
      return;
    }

    final videoId = _extractVideoId(url);

    if (videoId != null && videoId.isNotEmpty) {
      final controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
      );
      emit(
        state.copyWith(
          isPlayingVideo: true,
          youtubeController: controller,
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isPlayingVideo: false,
          isLoading: false,
          errorMessage: AppStrings.unableToLoadVideo,
        ),
      );
    }
  }

  String? _extractVideoId(String url) {
    final regExp = RegExp(
      AppStrings.youTubeVideoIdRegex,
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  void _closeVideo() {
    state.youtubeController?.close();
    emit(state.copyWith(isPlayingVideo: false, youtubeController: null));
  }

  @override
  Future<void> close() {
    state.youtubeController?.close();
    return super.close();
  }
}

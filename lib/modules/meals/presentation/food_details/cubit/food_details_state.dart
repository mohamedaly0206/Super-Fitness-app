import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodDetailsState extends Equatable {
  final BaseState getFoodDetailsState;
  final bool isLoading;
  final String? errorMessage;
  final List<Map<String, String>> validIngredients;

  final bool isPlayingVideo;
  final YoutubePlayerController? youtubeController;

  const FoodDetailsState({
    this.getFoodDetailsState = const BaseState(),
    this.isLoading = false,
    this.validIngredients = const [],
    this.isPlayingVideo = false,
    this.youtubeController,
    this.errorMessage,
  });

  FoodDetailsState copyWith({
    BaseState? getFoodDetailsState,
    bool? isLoading,
    List<Map<String, String>>? validIngredients,
    bool? isPlayingVideo,
    YoutubePlayerController? youtubeController,
    String? errorMessage,
  }) {
    return FoodDetailsState(
      getFoodDetailsState: getFoodDetailsState ?? this.getFoodDetailsState,
      isLoading: isLoading ?? this.isLoading,
      validIngredients: validIngredients ?? this.validIngredients,
      isPlayingVideo: isPlayingVideo ?? this.isPlayingVideo,
      youtubeController: youtubeController ?? this.youtubeController,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    getFoodDetailsState,
    isLoading,
    validIngredients,
    isPlayingVideo,
    youtubeController,
    errorMessage,
  ];
}

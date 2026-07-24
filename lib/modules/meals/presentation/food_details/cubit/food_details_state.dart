import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodDetailsState extends Equatable {
  final BaseState getFoodDetailsState;
  final bool isLoading;
  final List<Map<String, String>> validIngredients;

  final bool isPlayingVideo;
  final YoutubePlayerController? youtubeController;

  const FoodDetailsState({
    this.getFoodDetailsState = const BaseState(),
    this.isLoading = false,
    this.validIngredients = const [],
    this.isPlayingVideo = false,
    this.youtubeController,
  });

  FoodDetailsState copyWith({
    BaseState? getFoodDetailsState,
    bool? isLoading,
    List<Map<String, String>>? validIngredients,
    bool? isPlayingVideo,
    YoutubePlayerController? youtubeController,
  }) {
    return FoodDetailsState(
      getFoodDetailsState: getFoodDetailsState ?? this.getFoodDetailsState,
      isLoading: isLoading ?? this.isLoading,
      validIngredients: validIngredients ?? this.validIngredients,
      isPlayingVideo: isPlayingVideo ?? this.isPlayingVideo,
      youtubeController: youtubeController ?? this.youtubeController,
    );
  }

  @override
  List<Object?> get props => [
    getFoodDetailsState,
    isLoading,
    validIngredients,
    isPlayingVideo,
    youtubeController,
  ];
}

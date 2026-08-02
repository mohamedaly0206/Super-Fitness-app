import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/use_cases/get_meals_details_use_case.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_event.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final GetMealsDetailsUseCase getMealsDetailsUseCase;
  FoodDetailsCubit(this.getMealsDetailsUseCase) : super(FoodDetailsState());
  void doEvent(FoodDetailsEvent event) {
    switch (event) {
      case GetMealsDetailsEvent():
        getMealsDetails(event.mealId);
        break;

      case OpenYoutubeVideoEvent():
        _playInlineYoutubeVideo(event.videoUrl);
        break;
      case CloseYoutubeVideoEvent():
        _closeYoutubeVideo();
        break;
    }
  }

  Future<void> getMealsDetails(String mealId) async {
    emit(state.copyWith(getFoodDetailsState: BaseState(isLoading: true)));
    final response = await getMealsDetailsUseCase(mealId);
    switch (response) {
      case SuccessBaseResponse<MealsDetailsEntity>():
        final meal = response.data.meals?.first;
        List<Map<String, String>> parsedIngredients = [];

        if (meal != null) {
          parsedIngredients = _extractIngredients(meal);
        }
        emit(
          state.copyWith(
            getFoodDetailsState: BaseState(data: response.data),
            validIngredients: parsedIngredients,
          ),
        );

        break;
      case ErrorBaseResponse<MealsDetailsEntity>():
        emit(
          state.copyWith(
            getFoodDetailsState: BaseState(
              errorMessage: response.failure.message,
            ),
          ),
        );
        break;
    }
  }

  List<Map<String, String>> _extractIngredients(MealEntity meal) {
    List<Map<String, String>> tempIngredients = [];

    void addIfValid(String? ingredient, String? measure) {
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        tempIngredients.add({
          'name': ingredient.trim(),
          'amount': (measure != null && measure.trim().isNotEmpty)
              ? measure.trim()
              : '-',
        });
      }
    }

    addIfValid(meal.strIngredient1, meal.strMeasure1);
    addIfValid(meal.strIngredient2, meal.strMeasure2);
    addIfValid(meal.strIngredient3, meal.strMeasure3);
    addIfValid(meal.strIngredient4, meal.strMeasure4);
    addIfValid(meal.strIngredient5, meal.strMeasure5);
    addIfValid(meal.strIngredient6, meal.strMeasure6);
    addIfValid(meal.strIngredient7, meal.strMeasure7);
    addIfValid(meal.strIngredient8, meal.strMeasure8);
    addIfValid(meal.strIngredient9, meal.strMeasure9);
    addIfValid(meal.strIngredient10, meal.strMeasure10);
    addIfValid(meal.strIngredient11, meal.strMeasure11);
    addIfValid(meal.strIngredient12, meal.strMeasure12);
    addIfValid(meal.strIngredient13, meal.strMeasure13);
    addIfValid(meal.strIngredient14, meal.strMeasure14);
    addIfValid(meal.strIngredient15, meal.strMeasure15);
    addIfValid(meal.strIngredient16, meal.strMeasure16);
    addIfValid(meal.strIngredient17, meal.strMeasure17);
    addIfValid(meal.strIngredient18, meal.strMeasure18);
    addIfValid(meal.strIngredient19, meal.strMeasure19);
    addIfValid(meal.strIngredient20, meal.strMeasure20);

    return tempIngredients;
  }

  void _playInlineYoutubeVideo(String url) {
    emit(state.copyWith(isLoading: true));
    if (url.isEmpty) {
      return;
    }

    final videoId = _extractYoutubeId(url);

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

  // Bulletproof fallback for TheMealDB URLs without relying on Regex
  String? _extractYoutubeId(String url) {
    final RegExp regExp = RegExp(
      AppStrings.youTubeVideoIdRegex,

      caseSensitive: false,

      multiLine: false,
    );

    final match = regExp.firstMatch(url);

    return match?.group(1);
  }

  void _closeYoutubeVideo() {
    state.youtubeController?.close();
    emit(state.copyWith(isPlayingVideo: false, youtubeController: null));
  }

  @override
  Future<void> close() {
    state.youtubeController?.close();
    return super.close();
  }
}

sealed class FoodDetailsEvent {}

class GetMealsDetailsEvent extends FoodDetailsEvent {
  final String mealId;
  GetMealsDetailsEvent({required this.mealId});
}

class OpenYoutubeVideoEvent extends FoodDetailsEvent {
  final String videoUrl;
  OpenYoutubeVideoEvent({required this.videoUrl});
}

class CloseYoutubeVideoEvent extends FoodDetailsEvent {}

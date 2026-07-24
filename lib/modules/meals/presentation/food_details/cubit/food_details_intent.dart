sealed class FoodDetailsIntent {}

class GetMealsDetailsIntent extends FoodDetailsIntent {
  final String mealId;
  GetMealsDetailsIntent({required this.mealId});
}

class OpenYoutubeVideoIIntent extends FoodDetailsIntent {
  final String videoUrl;
  OpenYoutubeVideoIIntent({required this.videoUrl});
}
class CloseYoutubeVideoIntent extends FoodDetailsIntent {}
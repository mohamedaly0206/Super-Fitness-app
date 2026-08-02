import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/use_cases/get_meals_details_use_case.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_cubit.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_event.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_state.dart';

@GenerateNiceMocks([MockSpec<GetMealsDetailsUseCase>()])
import 'food_details_cubit_test.mocks.dart';

void main() {
  late FoodDetailsCubit cubit;
  late MockGetMealsDetailsUseCase mockGetMealsDetailsUseCase;

  // Register the dummy value for Mockito before any tests run
  setUpAll(() {
    provideDummy<BaseResponse<MealsDetailsEntity>>(
      SuccessBaseResponse<MealsDetailsEntity>(data: MealsDetailsEntity()),
    );
  });

  setUp(() {
    mockGetMealsDetailsUseCase = MockGetMealsDetailsUseCase();
    cubit = FoodDetailsCubit(mockGetMealsDetailsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const tMealId = '52772';

  final tMealEntity = MealEntity(
    strIngredient1: ' Chicken ',
    strMeasure1: ' 500g ',
    strIngredient2: ' Salt ',
    strMeasure2: null, // Test default '-' fallback
    strIngredient3: '',
    id: '',
    name: '',
    category: '',
    instructions: '',
    imageUrl: '',
    youtubeUrl: '', // Test empty string ignored
  );

  final tMealsDetailsEntity = MealsDetailsEntity(meals: [tMealEntity]);

  group('getMealsDetails', () {
    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [loading state, success state with extracted ingredients] when getMealsDetails is successful',
      build: () {
        when(mockGetMealsDetailsUseCase(tMealId)).thenAnswer(
          (_) async => SuccessBaseResponse<MealsDetailsEntity>(
            data: tMealsDetailsEntity,
          ),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(GetMealsDetailsEvent(mealId: tMealId)),
      expect: () => [
        // 1. Loading State
        isA<FoodDetailsState>().having(
          (s) => s.getFoodDetailsState.isLoading,
          'isLoading',
          true,
        ),
        // 2. Success State
        isA<FoodDetailsState>()
            .having(
              (s) => s.getFoodDetailsState.data,
              'data',
              tMealsDetailsEntity,
            )
            .having((s) => s.validIngredients, 'validIngredients', [
              {'name': 'Chicken', 'amount': '500g'},
              {'name': 'Salt', 'amount': '-'},
            ]),
      ],
      verify: (_) {
        verify(mockGetMealsDetailsUseCase(tMealId)).called(1);
      },
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [loading state, error state] when getMealsDetails fails',
      build: () {
        when(mockGetMealsDetailsUseCase(tMealId)).thenAnswer(
          (_) async => ErrorBaseResponse<MealsDetailsEntity>(
            failure: Failure(message: 'Failed to fetch details'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.getMealsDetails(tMealId),
      expect: () => [
        isA<FoodDetailsState>().having(
          (s) => s.getFoodDetailsState.isLoading,
          'isLoading',
          true,
        ),
        isA<FoodDetailsState>().having(
          (s) => s.getFoodDetailsState.errorMessage,
          'errorMessage',
          'Failed to fetch details',
        ),
      ],
    );
  });

  group('YouTube Player Logic', () {
    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits state with error message when video URL is invalid',
      build: () => cubit,
      act: (cubit) => cubit.doEvent(
        OpenYoutubeVideoEvent(videoUrl: 'invalid_url'),
      ),
      expect: () => [
        isA<FoodDetailsState>().having((s) => s.isLoading, 'isLoading', true),
        isA<FoodDetailsState>()
            .having((s) => s.isPlayingVideo, 'isPlayingVideo', false)
            .having((s) => s.isLoading, 'isLoading', false)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              AppStrings.unableToLoadVideo,
            ),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits isPlayingVideo = false and youtubeController = null when video is closed',
      build: () => cubit,
      act: (cubit) => cubit.doEvent(CloseYoutubeVideoEvent()),
      expect: () => [
        isA<FoodDetailsState>()
            .having((s) => s.isPlayingVideo, 'isPlayingVideo', false)
            .having((s) => s.youtubeController, 'youtubeController', null),
      ],
    );
  });
}

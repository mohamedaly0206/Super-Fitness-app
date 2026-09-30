import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:get_it/get_it.dart';

// --- Your App Imports ---
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_cubit.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_state.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/pages/food_details_page.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/food_details_shimmer.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/food_details_top_header.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/ingredients_widget.dart';

class MockFoodDetailsCubit extends MockCubit<FoodDetailsState>
    implements FoodDetailsCubit {}

class FakeFoodDetailsState extends Fake implements FoodDetailsState {}

void main() {
  late MockFoodDetailsCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeFoodDetailsState());

    // Optional: If your app requires a one-time global DI setup, call it here:
    // configureDependencies();
  });

  setUp(() {
    mockCubit = MockFoodDetailsCubit();

    // 1. Push a new scope for test isolation (replaces unsafe full resets)
    GetIt.instance.pushNewScope();

    // 2. Register our mocked cubit in this scope
    GetIt.instance.registerFactory<FoodDetailsCubit>(() => mockCubit);
  });

  tearDown(() async {
    mockCubit.close();
    // 3. Pop the scope after each test to clean up safely
    await GetIt.instance.popScope();
  });

  Widget buildTestableWidget() {
    return const MaterialApp(home: FoodDetailsPage(mealId: '12345'));
  }

  group('FoodDetailsPage Widget Tests', () {
    testWidgets('shows FoodDetailsShimmer when state is loading', (tester) async {
      when(() => mockCubit.state).thenReturn(
        const FoodDetailsState(
          getFoodDetailsState: BaseState(isLoading: true),
          isPlayingVideo: false,
          validIngredients: [],
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(FoodDetailsShimmer), findsOneWidget);
    });

    testWidgets('shows Error Message when state has an error', (tester) async {
      const errorMessage = 'Failed to load meal details';
      when(() => mockCubit.state).thenReturn(
        const FoodDetailsState(
          getFoodDetailsState: BaseState(errorMessage: errorMessage),
          isPlayingVideo: false,
          validIngredients: [],
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('shows FoodDetailsTopHeader and IngrediEntsWidget on success', (
      tester,
    ) async {
      final dummyMeal = MealEntity(
        id: '12345',
        name: 'Chicken Salad',
        imageUrl: 'https://example.com/image.jpg',
        youtubeUrl: 'https://youtube.com/watch?v=123',
        instructions: 'Mix it all together.',
        category: 'Salad',
      );

      final dummyIngredients = [
        {'name': 'Chicken', 'amount': '200g'},
        {'name': 'Lettuce', 'amount': '1 head'},
      ];

      when(() => mockCubit.state).thenReturn(
        FoodDetailsState(
          getFoodDetailsState: BaseState(
            data: MealsDetailsEntity(meals: [dummyMeal]),
          ),
          isPlayingVideo: false,
          validIngredients: dummyIngredients,
        ),
      );

      await mockNetworkImages(() async {
        await tester.pumpWidget(buildTestableWidget());
      });

      expect(find.byType(FoodDetailsTopHeader), findsOneWidget);
      expect(find.byType(IngrediEntsWidget), findsOneWidget);
      expect(find.text('Chicken Salad'), findsOneWidget);
      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('200g'), findsOneWidget);
    });
  });
}

// test/modules/meals/data/datasources/meals_remote_data_source_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/api/datasources/meals_remote_data_source_impl.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';

@GenerateNiceMocks([MockSpec<MealsApiClient>()])
import 'meals_remote_data_source_impl_test.mocks.dart';

void main() {
  late MealsRemoteDataSourceImpl dataSource;
  late MockMealsApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockMealsApiClient();
    dataSource = MealsRemoteDataSourceImpl(mockApiClient);
  });

  const tMealId = '52772';
  final tMealsDetailsDto = MealsDetailsDto(); // Inject properties as needed

  group('getMeals', () {
    test('should return SuccessBaseResponse when api call is successful', () async {
      // Arrange
      when(mockApiClient.getMeals(tMealId))
          .thenAnswer((_) async => tMealsDetailsDto);

      // Act
      final result = await dataSource.getMeals(tMealId);

      // Assert
      expect(result, isA<SuccessBaseResponse<MealsDetailsDto>>());
      expect((result as SuccessBaseResponse<MealsDetailsDto>).data, equals(tMealsDetailsDto));
      verify(mockApiClient.getMeals(tMealId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return ErrorBaseResponse when api call throws an exception', () async {
      // Arrange
      when(mockApiClient.getMeals(tMealId)).thenThrow(Exception('Server Failure'));

      // Act
      final result = await dataSource.getMeals(tMealId);

      // Assert
      expect(result, isA<ErrorBaseResponse<MealsDetailsDto>>());
      verify(mockApiClient.getMeals(tMealId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
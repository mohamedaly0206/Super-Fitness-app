// test/modules/meals/data/repositories/meals_repo_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/modules/meals/data/repositories/meals_repo_impl.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';

@GenerateNiceMocks([
  MockSpec<MealsRemoteDataSource>(),
  MockSpec<MealsDetailsDto>(),
])
import 'meals_repo_impl_test.mocks.dart';

void main() {
  late MealsRepoImpl repo;
  late MockMealsRemoteDataSource mockRemoteDataSource;

  // Register dummy values for Mockito before any tests run
  setUpAll(() {
    provideDummy<BaseResponse<MealsDetailsDto>>(
      SuccessBaseResponse<MealsDetailsDto>(data: MealsDetailsDto()),
    );
    provideDummy<BaseResponse<MealsDetailsEntity>>(
      SuccessBaseResponse<MealsDetailsEntity>(data: MealsDetailsEntity()),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockMealsRemoteDataSource();
    repo = MealsRepoImpl(mealsRemoteDataSource: mockRemoteDataSource);
  });

  const tMealId = '52772';
  final mockDto = MockMealsDetailsDto();
  final tEntity = MealsDetailsEntity();

  group('getMeals', () {
    test('should return SuccessBaseResponse<MealsDetailsEntity> when remote data source call is successful', () async {
      // Arrange
      when(mockDto.toDomain()).thenReturn(tEntity);
      when(mockRemoteDataSource.getMeals(tMealId))
          .thenAnswer((_) async => SuccessBaseResponse<MealsDetailsDto>(data: mockDto));

      // Act
      final result = await repo.getMeals(tMealId);

      // Assert
      expect(result, isA<SuccessBaseResponse<MealsDetailsEntity>>());
      expect((result as SuccessBaseResponse<MealsDetailsEntity>).data, equals(tEntity));
      verify(mockRemoteDataSource.getMeals(tMealId)).called(1);
    });

    test('should return ErrorBaseResponse<MealsDetailsEntity> when remote data source call fails', () async {
      // Arrange
      final tFailure = Failure(message: 'Server Error');
      when(mockRemoteDataSource.getMeals(tMealId))
          .thenAnswer((_) async => ErrorBaseResponse<MealsDetailsDto>(failure: tFailure));

      // Act
      final result = await repo.getMeals(tMealId);

      // Assert
      expect(result, isA<ErrorBaseResponse<MealsDetailsEntity>>());
      expect((result as ErrorBaseResponse<MealsDetailsEntity>).failure, equals(tFailure));
      verify(mockRemoteDataSource.getMeals(tMealId)).called(1);
    });
  });
}
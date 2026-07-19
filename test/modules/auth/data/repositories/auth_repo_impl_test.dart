import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart'; // Ensure correct import for Failure
import 'package:super_fitness_app/core/network/model/user.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/modules/auth/data/repositories/auth_repo_impl.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceContract {}

// 2. Create Fake classes for Mocktail fallbacks
class FakeRegisterRequestDto extends Fake implements RegisterRequestDto {}

void main() {
  late AuthRepoImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeRegisterRequestDto());
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepoImpl(mockRemoteDataSource);
  });

  group('register', () {
    // Dummy Domain Entity (Input)
    final tRequestEntity = RegisterRequestEntity(
      email: 'test@example.com',
      password: 'Password123!',
      firstName: 'name',
      lastName: 'last name',
      rePassword: 'Am@1234568',
      gender: Gender.male,
      age: 20,
      weight: 60.0,
      height: 170.0,
      goal: 'lose weight',
      activityLevel: 'level2',
    );
    final tUserDto = UserDto(
      20,
      60.0,
      170.0,
      'level2',
      'lose weight',
      firstName: 'name',
      lastName: 'last name',
      email: 'test@example.com',
      gender: 'male',
      id: '12345abcde',
    );

    final tResponseDto = RegisterResponseDto(
      message: 'Registration successful',
      user: tUserDto,
      token: 'fake_jwt_token',
    );

    final tResponseEntity = tResponseDto.toDomain();

    test(
      'should return SuccessBaseResponse<RegisterResponseEntity> when data source succeeds',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.register(any()),
        ).thenAnswer((_) async => SuccessBaseResponse(data: tResponseDto));

        // Act
        final result = await repository.register(tRequestEntity);

        // Assert
        expect(result, isA<SuccessBaseResponse<RegisterResponseEntity>>());

        final successResult =
            result as SuccessBaseResponse<RegisterResponseEntity>;

        expect(successResult.data, equals(tResponseEntity));

        final captured = verify(
          () => mockRemoteDataSource.register(captureAny()),
        ).captured;
        final passedDto = captured.first as RegisterRequestDto;

        expect(passedDto.email, equals(tRequestEntity.email));
        expect(passedDto.firstName, equals(tRequestEntity.firstName));

        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return ErrorBaseResponse<RegisterResponseEntity> when data source fails',
      () async {
        // Arrange
        final tFailure = Failure(message: 'Registration failed');

        when(
          () => mockRemoteDataSource.register(any()),
        ).thenAnswer((_) async => ErrorBaseResponse(failure: tFailure));

        // Act
        final result = await repository.register(tRequestEntity);

        // Assert
        expect(result, isA<ErrorBaseResponse<RegisterResponseEntity>>());

        final errorResult = result as ErrorBaseResponse<RegisterResponseEntity>;

        // Ensure the failure was passed through without modification
        expect(errorResult.failure, equals(tFailure));

        final captured = verify(
          () => mockRemoteDataSource.register(captureAny()),
        ).captured;
        final passedDto = captured.first as RegisterRequestDto;

        expect(passedDto.email, equals(tRequestEntity.email));
        expect(passedDto.firstName, equals(tRequestEntity.firstName));

        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}

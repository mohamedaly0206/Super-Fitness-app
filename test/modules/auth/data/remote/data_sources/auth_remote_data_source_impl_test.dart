import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user.dart'; // Ensure this points to where UserDto is
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/remote/api_client/auth_api_client.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_impl.dart';

// 1. Create a Mock for the AuthApiClient
class MockAuthApiClient extends Mock implements AuthApiClient {}

// 2. Create Fake classes for Mocktail fallbacks
class FakeRegisterRequestDto extends Fake implements RegisterRequestDto {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockAuthApiClient mockAuthApiClient;

  setUpAll(() {
    // Register fallbacks so mocktail knows how to handle 'any()' for custom objects
    registerFallbackValue(FakeRegisterRequestDto());
  });

  setUp(() {
    // Initialize the mock and the class under test before each test
    mockAuthApiClient = MockAuthApiClient();
    dataSource = AuthRemoteDataSourceImpl(mockAuthApiClient);
  });

  group('register', () {
    // Dummy request data
    final tRequest = RegisterRequestDto(
      email: 'test@example.com',
      password: 'Password123!',
      firstName: 'name',
      lastName: 'last name',
      rePassword: 'Am@1234568',
      gender: 'male',
      age: 20,
      weight: 60,
      height: 170,
      goal: 'lose weight',
      activityLevel: 'level2',
    );

    // Dummy UserDto to inject into the response
    // Note: age, weight, height, activityLevel, and goal are positional parameters
    final tUserDto = UserDto(
      20, // age
      60.0, // weight
      170.0, // height
      'level2', // activityLevel
      'lose weight', // goal
      firstName: 'name',
      lastName: 'last name',
      email: 'test@example.com',
      gender: 'male',
      id: '12345abcde',
    );

    // Dummy response data
    final tResponse = RegisterResponseDto(
      message: 'Registration successful',
      user: tUserDto,
      token: 'fake_jwt_token',
    );

    test(
      'should return SuccessBaseResponse containing RegisterResponseDto when the API call is successful',
      () async {
        // Arrange
        when(
          () => mockAuthApiClient.register(any()),
        ).thenAnswer((_) async => tResponse);

        // Act
        final result = await dataSource.register(tRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<RegisterResponseDto>>());

        final successResult =
            result as SuccessBaseResponse<RegisterResponseDto>;
        expect(successResult.data, equals(tResponse));

        verify(() => mockAuthApiClient.register(tRequest)).called(1);
        verifyNoMoreInteractions(mockAuthApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse containing a Failure when the API call throws an exception',
      () async {
        // Arrange
        final tException = Exception('Server connection failed');
        when(() => mockAuthApiClient.register(any())).thenThrow(tException);

        // Act
        final result = await dataSource.register(tRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<RegisterResponseDto>>());

        final errorResult = result as ErrorBaseResponse<RegisterResponseDto>;
        expect(errorResult.failure, isNotNull);

        verify(() => mockAuthApiClient.register(tRequest)).called(1);
        verifyNoMoreInteractions(mockAuthApiClient);
      },
    );
  });
}

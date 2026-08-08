import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/error/error_handler.dart'; // Adjust import path for Failure
import 'package:super_fitness_app/core/service/google_auth_service.dart';
import 'package:super_fitness_app/core/service/remote_config_service.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_state.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockGoogleAuthService extends Mock implements GoogleAuthService {}

class MockRemoteConfigService extends Mock implements RemoteConfigService {}

class FakeRegisterRequestEntity extends Fake implements RegisterRequestEntity {}

void main() {
  late RegisterCubit cubit;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGoogleAuthService mockGoogleAuthService;
  late MockRemoteConfigService mockRemoteConfigService;

  setUpAll(() {
    registerFallbackValue(FakeRegisterRequestEntity());
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockGoogleAuthService = MockGoogleAuthService();
    mockRemoteConfigService = MockRemoteConfigService();
    cubit = RegisterCubit(
      mockRegisterUseCase,
      mockGoogleAuthService,
      mockRemoteConfigService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be empty RegisterState', () {
    expect(cubit.state, equals(const RegisterState()));
  });

  group('Event Routing (Form Input Modifications)', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with updated gender when SelectGenderEvent is triggered',
      build: () => cubit,
      act: (cubit) => cubit.doEvent(SelectGenderEvent(Gender.male)),
      expect: () => [const RegisterState().copyWith(gender: Gender.male)],
    );

    blocTest<RegisterCubit, RegisterState>(
      'should emit state with updated age when SelectAgeEvent is triggered',
      build: () => cubit,
      act: (cubit) => cubit.doEvent(SelectAgeEvent(25)),
      expect: () => [const RegisterState().copyWith(age: 25)],
    );
  });

  group('SubmitRegisterEvent', () {
    final tRequest = RegisterRequestEntity(
      email: 'test@example.com',
      password: 'Password123!',
      firstName: 'John',
      lastName: 'Doe',
      rePassword: 'Password123!',
      gender: Gender.male,
      age: 25,
      weight: 70.0,
      height: 175.0,
      goal: 'Stay fit',
      activityLevel: 'level3',
    );

    const tResponseEntity = RegisterResponseEntity();

    blocTest<RegisterCubit, RegisterState>(
      'should emit [Loading, Success] when submission succeeds',
      build: () {
        when(
          () => mockRegisterUseCase.call(any()),
        ).thenAnswer((_) async => SuccessBaseResponse(data: tResponseEntity));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(SubmitRegisterEvent(request: tRequest)),
      expect: () => [
        // 1. Loading state gets emitted first
        const RegisterState().copyWith(isEmailRegisterLoading: true),
        // 2. Success state gets emitted with backend payload data
        // Note: The fields remain filled because copyWith ignores the subsequent null emissions
        const RegisterState().copyWith(
          registerState: const BaseState(data: tResponseEntity),
          isEmailRegisterLoading: false,
          isGoogleRegisterLoading: false,
          isFacebookRegisterLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(tRequest)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'should emit [Loading, Error] when submission fails',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async =>
              ErrorBaseResponse(failure: Failure(message: 'Server Error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(SubmitRegisterEvent(request: tRequest)),
      expect: () => [
        const RegisterState().copyWith(isEmailRegisterLoading: true),
        const RegisterState().copyWith(
          registerState: const BaseState(errorMessage: 'Server Error'),
          isEmailRegisterLoading: false,
          isGoogleRegisterLoading: false,
          isFacebookRegisterLoading: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(tRequest)).called(1);
      },
    );
  });
}

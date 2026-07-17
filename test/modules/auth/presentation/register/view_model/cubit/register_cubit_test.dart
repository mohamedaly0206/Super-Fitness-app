import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/error/error_handler.dart'; // Adjust import path for Failure
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class FakeRegisterRequestEntity extends Fake implements RegisterRequestEntity {}

void main() {
  late RegisterCubit cubit;
  late MockRegisterUseCase mockRegisterUseCase;

  setUpAll(() {
    registerFallbackValue(FakeRegisterRequestEntity());
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    cubit = RegisterCubit(mockRegisterUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be empty RegisterState', () {
    expect(cubit.state, equals(const RegisterState()));
  });

  group('Intent Routing (Form Input Modifications)', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with updated gender when SelectGenderIntent is triggered',
      build: () => cubit,
      act: (cubit) =>
          cubit.handleRegisterIntent(SelectGenderIntent(Gender.male)),
      expect: () => [const RegisterState().copyWith(gender: Gender.male)],
    );

    blocTest<RegisterCubit, RegisterState>(
      'should emit state with updated age when SelectAgeIntent is triggered',
      build: () => cubit,
      act: (cubit) => cubit.handleRegisterIntent(SelectAgeIntent(25)),
      expect: () => [const RegisterState().copyWith(age: 25)],
    );
  });

  group('SubmitRegisterIntent', () {
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
      act: (cubit) =>
          cubit.handleRegisterIntent(SubmitRegisterIntent(request: tRequest)),
      expect: () => [
        // 1. Loading state gets emitted first
        const RegisterState().copyWith(
          registerState: const BaseState(isLoading: true),
        ),
        // 2. Success state gets emitted with backend payload data
        // Note: The fields remain filled because copyWith ignores the subsequent null emissions
        const RegisterState().copyWith(
          registerState: const BaseState(data: tResponseEntity),
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
      act: (cubit) =>
          cubit.handleRegisterIntent(SubmitRegisterIntent(request: tRequest)),
      expect: () => [
        const RegisterState().copyWith(
          registerState: const BaseState(isLoading: true),
        ),
        const RegisterState().copyWith(
          registerState: const BaseState(errorMessage: 'Server Error'),
        ),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(tRequest)).called(1);
      },
    );
  });
}

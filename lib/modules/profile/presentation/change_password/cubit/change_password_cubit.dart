import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/profile_use_cases.dart';
import 'package:super_fitness_app/modules/profile/presentation/change_password/cubit/change_password_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/change_password/cubit/change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileUseCases _profileUseCases;

  ChangePasswordCubit({required ProfileUseCases profileUseCases})
    : _profileUseCases = profileUseCases,
      super(const ChangePasswordState());

  void doEvent(ChangePasswordEvent event) {
    switch (event) {
      case SubmitChangePasswordEvent():
        changePassword(password: event.password, newPassword: event.newPassword);
    }
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(
        changePasswordState: state.changePasswordState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    final response = await _profileUseCases.changePassword(
      password: password,
      newPassword: newPassword,
    );

    switch (response) {
      case SuccessBaseResponse<ChangePasswordEntity>():
        final token = response.data.token;
        if (token != null && token.isNotEmpty) {
          await SecureStorageService.saveToken(token);
        }
        emit(
          state.copyWith(
            changePasswordState: state.changePasswordState.copyWith(
              isLoadingParam: false,
              dataParam: true,
            ),
          ),
        );
      case ErrorBaseResponse<ChangePasswordEntity>():
        emit(
          state.copyWith(
            changePasswordState: state.changePasswordState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }
}

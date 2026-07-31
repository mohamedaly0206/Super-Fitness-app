import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/change_password_use_case.dart';

part 'change_password_state.dart';

@lazySingleton
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
    : super(const ChangePasswordState());

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    emit(state.copyWith(
      changePasswordState: state.changePasswordState.copyWith(
        isLoadingParam: true,
        errorMessageParam: null,
      ),
    ));

    final response = await changePasswordUseCase(
      password: password,
      newPassword: newPassword,
    );

    switch (response) {
      case SuccessBaseResponse<ChangePasswordEntity>():
        final token = response.data.token;
        if (token != null && token.isNotEmpty) {
          await SecureStorageService.saveToken(token);
        }
        emit(state.copyWith(
          changePasswordState: state.changePasswordState.copyWith(
            isLoadingParam: false,
            dataParam: true,
          ),
        ));
      case ErrorBaseResponse<ChangePasswordEntity>():
        emit(state.copyWith(
          changePasswordState: state.changePasswordState.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.failure.message,
          ),
        ));
    }
  }
}

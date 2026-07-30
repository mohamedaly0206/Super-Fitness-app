import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/logout_use_case.dart';

part 'logout_state.dart';

@lazySingleton
class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit({required this.logoutUseCase}) : super(const LogoutState());

  Future<void> logout() async {
    emit(state.copyWith(
      logoutState: state.logoutState.copyWith(
        isLoadingParam: true,
        errorMessageParam: null,
      ),
    ));

    final response = await logoutUseCase();

    switch (response) {
      case SuccessBaseResponse<LogoutEntity>():
        await SecureStorageService.deleteToken();
        emit(state.copyWith(
          logoutState: state.logoutState.copyWith(
            isLoadingParam: false,
            dataParam: true,
          ),
        ));
      case ErrorBaseResponse<LogoutEntity>():
        emit(state.copyWith(
          logoutState: state.logoutState.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.failure.message,
          ),
        ));
    }
  }
}

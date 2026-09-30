import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/profile_use_cases.dart';
import 'package:super_fitness_app/modules/profile/presentation/logout/cubit/logout_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/logout/cubit/logout_state.dart';

@injectable
class LogoutCubit extends Cubit<LogoutState> {
  final ProfileUseCases logoutUseCase;

  LogoutCubit({required this.logoutUseCase}) : super(const LogoutState());

  void doEvent(LogoutEvent event) {
    switch (event) {
      case LogoutRequestedEvent():
        logout();
    }
  }

  Future<void> logout() async {
    emit(
      state.copyWith(
        logoutState: state.logoutState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    final response = await logoutUseCase.logout();

    switch (response) {
      case SuccessBaseResponse<LogoutEntity>():
        await SecureStorageService.deleteToken();
        await SecureStorageService.deleteUserId();
        await SecureStorageService.deleteUserName();
        await SecureStorageService.deleteProfileImage();
        emit(
          state.copyWith(
            logoutState: state.logoutState.copyWith(
              isLoadingParam: false,
              dataParam: true,
            ),
          ),
        );
      case ErrorBaseResponse<LogoutEntity>():
        emit(
          state.copyWith(
            logoutState: state.logoutState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }
}

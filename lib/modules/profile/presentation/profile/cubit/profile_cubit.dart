import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';

import '../../../domain/use_cases/profile_use_cases.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCases _profileUseCases;

  ProfileCubit(this._profileUseCases) : super(const ProfileState());

  Future<void> doEvent(ProfileEvent event) async {
    switch (event) {
      case GetProfileDataEvent():
        await _getProfileData();
    }
  }

  Future<void> _getProfileData() async {
    emit(
      state.copyWith(
        baseState: state.baseState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    try {
      final user = await _profileUseCases.getProfile();
      await SecureStorageService.saveUser(user);

      emit(
        state.copyWith(
          baseState: state.baseState.copyWith(isLoadingParam: false),
          user: user,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          baseState: state.baseState.copyWith(
            isLoadingParam: false,
            errorMessageParam: e.toString(),
          ),
        ),
      );
    }
  }
}

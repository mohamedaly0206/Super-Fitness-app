import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/profile_use_cases.dart';
import 'profile_intent.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCases _profileUseCases;

  ProfileCubit(this._profileUseCases) : super(const ProfileState());

  Future<void> doIntent(ProfileIntent intent) async {
    switch (intent) {
      case GetProfileDataIntent():
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

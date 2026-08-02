import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:super_fitness_app/modules/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;
  EditProfileCubit(this._editProfileUseCase, this._uploadProfileImageUseCase)
    : super(EditProfileState());
  final picker = ImagePicker();

  void doEvent(EditProfileEvent event) {
    switch (event) {
      case InitUserDataEvent():
        _initUserData(event.userData);
        break;
      case FirstNameChangedEvent():
        emit(state.copyWith(firstName: event.firstName));
        break;
      case LastNameChangedEvent():
          emit(state.copyWith(lastName: event.lastName));
        break;
      case EmailChangedEvent():
        emit(state.copyWith(email: event.email));
        break;
      case SelectWeightEvent():
        _changeWeight(event.weight);
        break;
      case SelectGoalEvent():
        _changeGoal(event.goal);
        break;
      case SelectActivityLevelEvent():
        _changeActivityLevel(event.activityLevel, event.activityLevelValue);
        break;
      case PickProfileImageEvent():
        pickImagePicker();
        break;
      case SubmitEditProfileEvent():
        _submitEditProfile();
        break;
      case UploadProfileImageEvent():
        _uploadProfileImage();
        break;
      case UpdateProfileImageAndDataEvent():
        updateProfileImageAndData();
        break;
    }
  }

  void _changeWeight(int weight) {
    emit(state.copyWith(weight: weight));
    log(state.weight.toString());
  }

  void _changeGoal(String goal) {
    emit(state.copyWith(goal: goal));
    log(state.goal.toString());
  }

  void _changeActivityLevel(String activityLevel, String activityLevelValue) {
    emit(
      state.copyWith(
        activityLevel: activityLevel,
        activityLevelValue: activityLevelValue,
      ),
    );
    log(state.activityLevel.toString());
  }

  Future<void> pickImagePicker() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null && picked.path.isNotEmpty) {
      emit(state.copyWith(imageFile: File(picked.path)));
    }
  }

  void _initUserData(UserEntity userData) {
    final weightParsing = userData.weight?.toInt() ?? 60;
    emit(
      state.copyWith(
        initialUserData: userData,
        firstName: userData.firstName,
        lastName: userData.lastName,
        email: userData.email,
        weight: weightParsing,
        goal: userData.goal,
        activityLevel: userData.activityLevel,
      ),
    );
  }

  Future<void> _submitEditProfile() async {
    emit(state.copyWith(editProfileState: BaseState(isLoading: true)));
    final result = await _editProfileUseCase.call(
      EditProfileRequest(
        firstName: state.firstName ?? '',
        lastName: state.lastName ?? '',
        email: state.email ?? '',
        weight: state.weight ?? 0,
        goal: state.goal ?? '',
        activityLevel: state.activityLevel ?? '',
      ),
    );
    switch (result) {
      case SuccessBaseResponse<UserEntity>():
        await SecureStorageService.saveUser(result.data);
        emit(
          state.copyWith(
            editProfileState: BaseState(
              data: result.data,
              isLoading: false,
              errorMessage: null,
            ),
          ),
        );
        log('Edit profile success: ${result.data}');
        break;
      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: BaseState(
              errorMessage: result.failure.message,
              isLoading: false,
            ),
          ),
        );
        log('Edit profile failed: ${result.failure.message}');
        break;
    }
  }

  Future<void> _uploadProfileImage() async {
    if (isClosed) return;

    emit(
      state.copyWith(uploadProfileImageState: const BaseState(isLoading: true)),
    );

    final result = await _uploadProfileImageUseCase(state.imageFile!);

    if (isClosed) return;

    switch (result) {
      case SuccessBaseResponse<UploadProfileImageEntity>():
        emit(
          state.copyWith(
            uploadProfileImageState: BaseState(
              data: result.data,
              isLoading: false,
              errorMessage: null,
            ),
          ),
        );
        emit(state.copyWith(imageFile: null));

      case ErrorBaseResponse<UploadProfileImageEntity>():
        emit(
          state.copyWith(
            uploadProfileImageState: BaseState(
              errorMessage: result.failure.message,
              isLoading: false,
            ),
          ),
        );
    }
  }

  Future<void> updateProfileImageAndData() async {
    if (state.imageFile != null) {
      await _uploadProfileImage();
    }
    await _submitEditProfile();
  }

  @override
  Future<void> close() {
    log('EditProfileCubit CLOSED');
    return super.close();
  }
}

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
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_intent.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;
  EditProfileCubit(this._editProfileUseCase, this._uploadProfileImageUseCase)
    : super(EditProfileState());
  final picker = ImagePicker();

  void handleEditProfileIntent(EditProfileIntent intent) {
    switch (intent) {
      case InitUserDataIntent():
        _initUserData(intent.userData);
        break;
      case FirstNameChangedIntent():
        emit(state.copyWith(firstName: intent.firstName));
        break;
      case LastNameChangedIntent():
        emit(state.copyWith(lastName: intent.lastName));
        break;
      case EmailChangedIntent():
        emit(state.copyWith(email: intent.email));
        break;
      case SelectWeightIntent():
        _changeWeight(intent.weight);
        break;
      case SelectGoalIntent():
        _changeGoal(intent.goal);
        break;
      case SelectActivityLevelIntent():
        _changeActivityLevel(intent.activityLevel, intent.activityLevelValue);
        break;
      case PickProfileImageIntent():
        pickImagePicker();
        break;
      case SubmitEditProfileIntent():
        _submitEditProfile();
        break;
      case UploadProfileImageIntent():
        _uploadProfileImage();
        break;
      case UpdateProfileImageAndDataIntent():
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

import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

class EditProfileState extends Equatable {
  final BaseState editProfileState;
  final BaseState uploadProfileImageState;
  final UserEntity? initialUserData;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? weight;
  final String? goal;
  final String? activityLevel;
  final String? activityLevelValue;
  final File? imageFile;

  const EditProfileState({
    this.firstName,
    this.lastName,
    this.email,
    this.editProfileState = const BaseState(),
    this.weight = 60,
    this.goal,
    this.activityLevel,
    this.imageFile,
    this.activityLevelValue,
    this.initialUserData,
    this.uploadProfileImageState = const BaseState(),
  });
  bool get isUserDataChanged {
    final user = initialUserData;
    if (user == null) return false;

    return firstName != user.firstName ||
        lastName != user.lastName ||
        email != user.email ||
        weight != user.weight ||
        goal != user.goal ||
        activityLevel != user.activityLevel;
  }

  bool get isProfileImageChanged => imageFile != null;

  EditProfileState copyWith({
    BaseState? editProfileState,
    UserEntity? initialUserData,
    String? firstName,
    String? lastName,
    String? email,
    int? weight,
    String? goal,
    String? activityLevel,
    String? imagePath,
    String? activityLevelValue,
    File? imageFile,
    BaseState? uploadProfileImageState,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      initialUserData: initialUserData ?? this.initialUserData,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      activityLevelValue: activityLevelValue ?? this.activityLevelValue,
      imageFile: imageFile ?? this.imageFile,
      uploadProfileImageState:
          uploadProfileImageState ?? this.uploadProfileImageState,
    );
  }

  @override
  List<Object?> get props => [
    editProfileState,
    initialUserData,
    firstName,
    lastName,
    email,
    weight,
    goal,
    activityLevel,
    activityLevelValue,
    imageFile,
    uploadProfileImageState,
  ];
}

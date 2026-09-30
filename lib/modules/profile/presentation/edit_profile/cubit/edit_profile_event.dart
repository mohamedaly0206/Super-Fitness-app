import 'package:super_fitness_app/core/network/model/user_entity.dart';

sealed class EditProfileEvent {}

class SubmitEditProfileEvent extends EditProfileEvent {}

class FirstNameChangedEvent extends EditProfileEvent {
  final String firstName;
  FirstNameChangedEvent(this.firstName);
}

class UpdateProfileImageAndDataEvent extends EditProfileEvent {}

class LastNameChangedEvent extends EditProfileEvent {
  final String lastName;
  LastNameChangedEvent(this.lastName);
}

class EmailChangedEvent extends EditProfileEvent {
  final String email;
  EmailChangedEvent(this.email);
}

class UploadProfileImageEvent extends EditProfileEvent {}

class PickProfileImageEvent extends EditProfileEvent {}

class SelectWeightEvent extends EditProfileEvent {
  final int weight;
  SelectWeightEvent(this.weight);
}

class SelectGoalEvent extends EditProfileEvent {
  final String goal;
  SelectGoalEvent(this.goal);
}

class SelectActivityLevelEvent extends EditProfileEvent {
  final String activityLevel;
  final String activityLevelValue;
  SelectActivityLevelEvent(this.activityLevel, this.activityLevelValue);
}

class InitUserDataEvent extends EditProfileEvent {
  final UserEntity userData;
  InitUserDataEvent(this.userData);
}

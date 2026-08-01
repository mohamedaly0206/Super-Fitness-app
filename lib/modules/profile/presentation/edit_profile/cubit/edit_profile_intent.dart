import 'package:super_fitness_app/core/network/model/user_entity.dart';

sealed class EditProfileIntent {}

class SubmitEditProfileIntent extends EditProfileIntent {}

class FirstNameChangedIntent extends EditProfileIntent {
  final String firstName;
  FirstNameChangedIntent(this.firstName);
}

class UpdateProfileImageAndDataIntent extends EditProfileIntent {}

class LastNameChangedIntent extends EditProfileIntent {
  final String lastName;
  LastNameChangedIntent(this.lastName);
}

class EmailChangedIntent extends EditProfileIntent {
  final String email;
  EmailChangedIntent(this.email);
}

class UploadProfileImageIntent extends EditProfileIntent {}

class PickProfileImageIntent extends EditProfileIntent {}

class SelectWeightIntent extends EditProfileIntent {
  final int weight;
  SelectWeightIntent(this.weight);
}

class SelectGoalIntent extends EditProfileIntent {
  final String goal;
  SelectGoalIntent(this.goal);
}

class SelectActivityLevelIntent extends EditProfileIntent {
  final String activityLevel;
  final String activityLevelValue;
  SelectActivityLevelIntent(this.activityLevel, this.activityLevelValue);
}

class InitUserDataIntent extends EditProfileIntent {
  final UserEntity userData;
  InitUserDataIntent(this.userData);
}

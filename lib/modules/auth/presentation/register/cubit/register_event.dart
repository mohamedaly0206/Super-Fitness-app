import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_state.dart';

sealed class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final RegisterRequestEntity request;
  SubmitRegisterEvent({required this.request});
}

class SelectGenderEvent extends RegisterEvent {
  final Gender gender;

  SelectGenderEvent(this.gender);
}

class SelectAgeEvent extends RegisterEvent {
  final num age;
  SelectAgeEvent(this.age);
}

class SelectWeightEvent extends RegisterEvent {
  final num weight;
  SelectWeightEvent(this.weight);
}

class SelectHeightEvent extends RegisterEvent {
  final num height;
  SelectHeightEvent(this.height);
}

class SelectGoalEvent extends RegisterEvent {
  final String goal;
  SelectGoalEvent(this.goal);
}

class SelectActivityLevelEvent extends RegisterEvent {
  final String activityLevel;
  SelectActivityLevelEvent(this.activityLevel, String activityValue);
}

class GoogleRegisterEvent extends RegisterEvent {}

class FacebookRegisterEvent extends RegisterEvent {}

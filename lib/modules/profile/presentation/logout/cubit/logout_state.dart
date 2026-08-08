import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';

class LogoutState extends Equatable {
  final BaseState<bool> logoutState;

  const LogoutState({this.logoutState = const BaseState<bool>()});

  LogoutState copyWith({BaseState<bool>? logoutState}) {
    return LogoutState(logoutState: logoutState ?? this.logoutState);
  }

  @override
  List<Object?> get props => [logoutState];
}

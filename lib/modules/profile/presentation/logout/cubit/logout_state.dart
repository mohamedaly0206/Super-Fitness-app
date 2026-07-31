part of 'logout_cubit.dart';

class LogoutState extends Equatable {
  final BaseState<bool> logoutState;

  const LogoutState({this.logoutState = const BaseState<bool>()});

  LogoutState copyWith({BaseState<bool>? logoutState}) {
    return LogoutState(logoutState: logoutState ?? this.logoutState);
  }

  @override
  List<Object?> get props => [logoutState];
}

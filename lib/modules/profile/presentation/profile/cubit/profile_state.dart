import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

class ProfileState extends Equatable {
  final BaseState<void> baseState;
  final UserEntity? user;

  const ProfileState({this.baseState = const BaseState<void>(), this.user});

  ProfileState copyWith({BaseState<void>? baseState, UserEntity? user}) {
    return ProfileState(
      baseState: baseState ?? this.baseState,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [baseState, user];
}

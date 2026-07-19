import 'package:equatable/equatable.dart';
import '../../../../../../config/base/base_state.dart';
import '../../../../../../core/network/model/user_entity.dart';

class LoginState extends Equatable {
  final BaseState<UserEntity> loginState;

  const LoginState({this.loginState = const BaseState<UserEntity>()});

  LoginState copyWith({BaseState<UserEntity>? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}

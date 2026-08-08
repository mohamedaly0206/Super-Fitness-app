import 'package:equatable/equatable.dart';
import '../../../../../../config/base/base_state.dart';
import '../../../../../../core/network/model/user_entity.dart';

enum LoginMethod { email, google, facebook }

class LoginState extends Equatable {
  final BaseState<UserEntity> loginState;
  final bool isEmailLoginLoading;
  final bool isGoogleLoginLoading;
  final bool isFacebookLoginLoading;

  const LoginState({
    this.loginState = const BaseState<UserEntity>(),
    this.isEmailLoginLoading = false,
    this.isGoogleLoginLoading = false,
    this.isFacebookLoginLoading = false,
  });

  LoginState copyWith({
    BaseState<UserEntity>? loginState,
    bool? isEmailLoginLoading,
    bool? isGoogleLoginLoading,
    bool? isFacebookLoginLoading,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isEmailLoginLoading: isEmailLoginLoading ?? this.isEmailLoginLoading,
      isGoogleLoginLoading: isGoogleLoginLoading ?? this.isGoogleLoginLoading,
      isFacebookLoginLoading:
          isFacebookLoginLoading ?? this.isFacebookLoginLoading,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        isEmailLoginLoading,
        isGoogleLoginLoading,
        isFacebookLoginLoading,
      ];
}

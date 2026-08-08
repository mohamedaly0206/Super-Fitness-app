sealed class LoginEvent {}

class SubmitLoginEvent extends LoginEvent {
  final String email;
  final String password;

  SubmitLoginEvent({required this.email, required this.password});
}

class GoogleLoginEvent extends LoginEvent {}

class FacebookLoginEvent extends LoginEvent {}

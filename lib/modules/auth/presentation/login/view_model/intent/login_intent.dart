sealed class LoginIntent {}

class SubmitLoginIntent extends LoginIntent {
  final String email;
  final String password;

  SubmitLoginIntent({required this.email, required this.password});
}
class GoogleLoginIntent extends LoginIntent {}
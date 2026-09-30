sealed class ChangePasswordEvent {}

class SubmitChangePasswordEvent extends ChangePasswordEvent {
  final String password;
  final String newPassword;

  SubmitChangePasswordEvent({
    required this.password,
    required this.newPassword,
  });
}

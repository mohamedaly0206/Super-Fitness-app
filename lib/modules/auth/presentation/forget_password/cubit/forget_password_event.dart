sealed class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

/// Email

class EmailChangedIntent extends ForgetPasswordEvent {
  final String email;

  const EmailChangedIntent(this.email);
}

class SubmitEmailIntent extends ForgetPasswordEvent {
  const SubmitEmailIntent();
}

/// OTP

class OtpChangedIntent extends ForgetPasswordEvent {
  final String otp;

  const OtpChangedIntent(this.otp);
}

class VerifyOtpIntent extends ForgetPasswordEvent {
  const VerifyOtpIntent();
}

class ResendOtpIntent extends ForgetPasswordEvent {
  const ResendOtpIntent();
}

/// Password

class PasswordChangedIntent extends ForgetPasswordEvent {
  final String password;

  const PasswordChangedIntent(this.password);
}

class ConfirmPasswordChangedIntent extends ForgetPasswordEvent {
  final String password;

  const ConfirmPasswordChangedIntent(this.password);
}

class SubmitNewPasswordIntent extends ForgetPasswordEvent {
  const SubmitNewPasswordIntent();
}

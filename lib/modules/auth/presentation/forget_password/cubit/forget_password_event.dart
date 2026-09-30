sealed class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

/// Email

class EmailChangedEvent extends ForgetPasswordEvent {
  final String email;

  const EmailChangedEvent(this.email);
}

class SubmitEmailEvent extends ForgetPasswordEvent {
  const SubmitEmailEvent();
}

/// OTP

class OtpChangedEvent extends ForgetPasswordEvent {
  final String otp;

  const OtpChangedEvent(this.otp);
}

class VerifyOtpEvent extends ForgetPasswordEvent {
  const VerifyOtpEvent();
}

class ResendOtpEvent extends ForgetPasswordEvent {
  const ResendOtpEvent();
}

/// Password

class PasswordChangedEvent extends ForgetPasswordEvent {
  final String password;

  const PasswordChangedEvent(this.password);
}

class ConfirmPasswordChangedEvent extends ForgetPasswordEvent {
  final String password;

  const ConfirmPasswordChangedEvent(this.password);
}

class SubmitNewPasswordEvent extends ForgetPasswordEvent {
  const SubmitNewPasswordEvent();
}

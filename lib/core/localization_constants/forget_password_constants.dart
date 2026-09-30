import 'package:easy_localization/easy_localization.dart';

abstract class ForgetPasswordConstants {
  ForgetPasswordConstants._();

  // Email Step
  static String get enterYourEmail => "forgetPassword.enterYourEmail".tr();

  static String get forgetPassword => "forgetPassword.forgetPassword".tr();

  static String get emailHint => "forgetPassword.emailHint".tr();

  static String get sendOtp => "forgetPassword.sendOtp".tr();

  // OTP Step
  static String get otpTitle => "forgetPassword.otpTitle".tr();

  static String get otpSubtitle => "forgetPassword.otpSubtitle".tr();

  static String get confirm => "forgetPassword.confirm".tr();

  static String get didntReceiveCode => "forgetPassword.didntReceiveCode".tr();

  static String get resendCode => "forgetPassword.resendCode".tr();

  static String get resendIn => "forgetPassword.resendIn".tr();

  static String get invalidCode => "forgetPassword.invalidCode".tr();

  // Reset Password Step
  static String get createNewPassword =>
      "forgetPassword.createNewPassword".tr();

  static String get passwordSubtitle => "forgetPassword.passwordSubtitle".tr();

  static String get passwordHint => "forgetPassword.passwordHint".tr();

  static String get confirmPasswordHint =>
      "forgetPassword.confirmPasswordHint".tr();

  static String get done => "forgetPassword.done".tr();

  // Validation
  static String get emailRequired =>
      "forgetPassword.validation.emailRequired".tr();

  static String get invalidEmail =>
      "forgetPassword.validation.invalidEmail".tr();

  static String get passwordRequired =>
      "forgetPassword.validation.passwordRequired".tr();

  static String get passwordLength =>
      "forgetPassword.validation.passwordLength".tr();

  static String get confirmPasswordRequired =>
      "forgetPassword.validation.confirmPasswordRequired".tr();

  static String get passwordNotMatch =>
      "forgetPassword.validation.passwordNotMatch".tr();

  static String get otpRequired => "forgetPassword.validation.otpRequired".tr();

  static const String emailKey = "email";
  static const String resetKey = "reset";
  static const String otpKey = "otp";
}

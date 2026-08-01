import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ProfileConstants on BuildContext {
  String get profile => "profile.profile".tr();
  String get logout => "profile.logout".tr();
  String get logoutConfirmationTitle =>
      "profile.logout_confirmation_title".tr();
  String get yes => "profile.yes".tr();
  String get no => "profile.no".tr();
  String get changePassword => "profile.change_password".tr();
  String get changePasswordSubtitle => "profile.change_password_subtitle".tr();
  String get createNewPassword => "profile.create_new_password".tr();
  String get oldPassword => "profile.old_password".tr();
  String get newPassword => "profile.new_password".tr();
  String get confirmPassword => "profile.confirm_password".tr();
  String get done => "profile.done".tr();
  String get editProfile => 'profile.edit_profile'.tr();
  String get yourActivityLevel => 'profile.your_activity_level'.tr();
  String get yourGoal => 'profile.your_goal'.tr();
  String get yourWeight => 'profile.your_weight'.tr();
  String get saveChanges => 'profile.save_changes'.tr();
  String get tapToEdit => 'profile.tap_to_edit'.tr();
  String get profileUpdatedSuccessfully =>
      'profile.profile_updated_successfully'.tr();
  String get kg => 'profile.kg'.tr();
  String get profileImageUpdatedSuccessfully =>
      'profile.profile_image_updated_successfully'.tr();
}

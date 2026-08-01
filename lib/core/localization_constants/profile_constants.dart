import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ProfileConstants on BuildContext {
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ProfileConstants on BuildContext {
  String get profile => "profile.profile".tr();
  String get logout => "profile.logout".tr();
  String get logoutConfirmationTitle =>
      "profile.logout_confirmation_title".tr();
  String get yes => "profile.yes".tr();
  String get no => "profile.no".tr();
}

import 'package:flutter/material.dart';

class ProfileItemData {
  final Widget leadingIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  ProfileItemData({
    required this.leadingIcon,
    required this.title,
    this.trailing,
    this.onTap,
  });
}

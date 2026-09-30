import 'package:flutter/widgets.dart';

class ProfileItemData {
  final Widget? leadingIcon;
  final String title;
  final Widget? customTitleWidget;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? textColor;

  ProfileItemData({
    this.leadingIcon,
    required this.title,
    this.customTitleWidget,
    this.trailing,
    this.onTap,
    this.textColor,
  });
}

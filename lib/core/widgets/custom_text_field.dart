import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isPassword;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.validator,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.textInputAction,
    this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.borderColor ?? AppColors.borderDefault;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? obscureText : false,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      style: const TextStyle(fontSize: 14, height: 1.2),
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.labelText,
        hintText: widget.hintText,
        constraints: const BoxConstraints(
          minHeight: AppSize.s36,
          maxHeight: AppSize.s36,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: 6,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: BorderSide(color: borderColor, width: AppSize.borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: BorderSide(color: borderColor, width: AppSize.borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: const BorderSide(
            color: AppColors.borderFocused,
            width: AppSize.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: const BorderSide(
            color: AppColors.borderError,
            width: AppSize.borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: const BorderSide(
            color: AppColors.borderError,
            width: AppSize.borderWidth,
          ),
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: AppPadding.p8),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                    AppPng.eye,
                    width: AppSize.svgIconSize,
                    height: AppSize.svgIconSize,
                    color: AppColors.grey12,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              )
            : null,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: AppPadding.p8),
                child: widget.prefixIcon,
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: AppSize.s24 + AppPadding.p8 + AppPadding.p8,
          minHeight: AppSize.s20,
        ),
      ),
    );
  }
}

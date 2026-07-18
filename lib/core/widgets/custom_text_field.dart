import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
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
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? obscureText : false,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        constraints: const BoxConstraints(minHeight: AppSize.s36),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: const BorderSide(
            color: AppColors.borderDefault,
            width: AppSize.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          borderSide: const BorderSide(
            color: AppColors.borderDefault,
            width: AppSize.borderWidth,
          ),
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
            ? GestureDetector(
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 24,
                ),
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
                child: widget.prefixIcon,
              ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }
}

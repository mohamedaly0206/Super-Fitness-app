import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.onChanged,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.prefixIcon,
    this.textInputAction,
  });

  final String? hintText;
  final String? labelText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscureText,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.labelText,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p8,
        ),
        border: _border(AppColors.borderDefault),
        enabledBorder: _border(AppColors.borderDefault),
        focusedBorder: _border(AppColors.borderFocused),
        errorBorder: _border(AppColors.borderError),
        focusedErrorBorder: _border(AppColors.borderError),
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
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
      borderSide: BorderSide(color: color, width: AppSize.borderWidth),
    );
  }
}

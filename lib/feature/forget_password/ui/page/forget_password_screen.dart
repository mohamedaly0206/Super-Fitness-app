import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_event.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_step.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_step_switcher.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.base != current.base ||
          previous.navigateToLogin != current.navigateToLogin,
      listener: (context, state) {
        if (state.navigateToLogin) {
          Navigator.pushReplacementNamed(context, Routes.login);
          return;
        }

        if (state.base.errorMessage != null &&
            state.step != ForgetPasswordStep.otp) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.base.errorMessage!)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();

        return CustomScaffold(
          background: Backgrounds.forgetPassword,
          body: SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // padding: EdgeInsets.only(
            //   bottom: MediaQuery.of(context).viewInsets.bottom,
            // ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppSizedBox(height: 46),
                    SizedBox(
                      height: 120,
                      child: Image.asset(AppPng.logo2, fit: BoxFit.contain),
                    ),
                    ForgetPasswordStepSwitcher(
                      state: state,
                      actions: ForgetPasswordActions(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        onEmailChanged: (v) =>
                            cubit.doIntent(EmailChangedIntent(v)),
                        onOtpChanged: (v) =>
                            cubit.doIntent(OtpChangedIntent(v)),
                        onPasswordChanged: (v) =>
                            cubit.doIntent(PasswordChangedIntent(v)),
                        onConfirmPasswordChanged: (v) =>
                            cubit.doIntent(ConfirmPasswordChangedIntent(v)),
                        onContinue: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.doIntent(const SubmitEmailIntent());
                          }
                        },
                        onCompletedOtp: () {
                          cubit.doIntent(const VerifyOtpIntent());
                        },
                        onReset: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.doIntent(const SubmitNewPasswordIntent());
                          }
                        },
                        onResend: () {
                          cubit.doIntent(const ResendOtpIntent());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

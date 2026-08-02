import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_step.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/widgets/forget_password_step_switcher.dart';

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
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 6,
                    right: 6,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    top: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSizedBox(height: 30),
                        SizedBox(
                          height: 120,
                          child: Image.asset(AppPng.logo2, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),
                        ForgetPasswordStepSwitcher(
                          state: state,
                          actions: ForgetPasswordActions(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            onEmailChanged: (v) =>
                                cubit.doEvent(EmailChangedEvent(v)),
                            onOtpChanged: (v) =>
                                cubit.doEvent(OtpChangedEvent(v)),
                            onPasswordChanged: (v) =>
                                cubit.doEvent(PasswordChangedEvent(v)),
                            onConfirmPasswordChanged: (v) =>
                                cubit.doEvent(ConfirmPasswordChangedEvent(v)),
                            onContinue: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.doEvent(const SubmitEmailEvent());
                              }
                            },
                            onCompletedOtp: () {
                              cubit.doEvent(const VerifyOtpEvent());
                            },
                            onReset: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.doEvent(const SubmitNewPasswordEvent());
                              }
                            },
                            onResend: () {
                              cubit.doEvent(const ResendOtpEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

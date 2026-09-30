import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/auth_or_divider.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/login_redirect_row.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_form_fields.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_submit_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/social_login_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToNextStep() {
    if (widget.pageController.hasClients) {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onRegisterPressed() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<RegisterCubit>();
    cubit.updateFirstName(_firstNameController.text.trim());
    cubit.updateLastName(_lastNameController.text.trim());
    cubit.updateEmail(_emailController.text.trim());
    cubit.updatePassword(_passwordController.text);

    _navigateToNextStep();
  }

  void _onGooglePressed() {
    context.read<RegisterCubit>().doEvent(GoogleRegisterEvent());
  }

  void _onFacebookPressed() {
    context.read<RegisterCubit>().doEvent(FacebookRegisterEvent());
  }

  void _onLoginPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          previous.registerState != current.registerState ||
          previous.email != current.email ||
          previous.isEmailRegisterLoading != current.isEmailRegisterLoading ||
          previous.isGoogleRegisterLoading != current.isGoogleRegisterLoading ||
          previous.isFacebookRegisterLoading !=
              current.isFacebookRegisterLoading,
      listener: (context, state) {
        if (state.registerState.errorMessage != null &&
            state.registerState.errorMessage!.isNotEmpty) {
          CustomSnackBar.error(context, state.registerState.errorMessage!);
        }

        if (state.email != null &&
            state.email!.isNotEmpty &&
            !state.isEmailRegisterLoading &&
            !state.isGoogleRegisterLoading &&
            !state.isFacebookRegisterLoading) {
          _firstNameController.text = state.firstName ?? '';
          _lastNameController.text = state.lastName ?? '';
          _emailController.text = state.email ?? '';
          _passwordController.text = state.password ?? '';

          _navigateToNextStep();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSizedBox(height: AppSize.s20),
                CustomContainer(
                  borderRadius: AppSize.borderRadiusLarge,
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Column(
                    children: [
                      Text(
                        AuthConstants.register,
                        style: getBoldStyle(
                          context: context,
                          color: AppColors.textPrimary,
                          fontSize: FontSizeManager.s24,
                        ),
                      ),
                      const AppSizedBox(height: AppSize.s20),
                      RegisterFormFields(
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      const AppSizedBox(height: AppSize.s20),
                      const AuthOrDivider(),
                      const AppSizedBox(height: AppSize.s20),
                      SocialLoginButtons(
                        onFacebookTap: _onFacebookPressed,
                        onGoogleTap: _onGooglePressed,
                        onAppleTap: () {
                          CustomSnackBar.info(
                            context,
                            AuthConstants.appleLoginUnavailable,
                          );
                        },
                        isGoogleLoading: state.isGoogleRegisterLoading,
                        isFacebookLoading: state.isFacebookRegisterLoading,
                      ),
                      const AppSizedBox(height: AppSize.s20),
                      RegisterSubmitButton(
                        isLoading: state.isEmailRegisterLoading,
                        onTap: _onRegisterPressed,
                      ),
                      const AppSizedBox(height: AppSize.s20),
                      LoginRedirectRow(onLoginTap: _onLoginPressed),
                    ],
                  ),
                ),
                const AppSizedBox(height: AppSize.s24),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/service/google_auth_service.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/auth_or_divider.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/login_redirect_row.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_form_fields.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_header.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_submit_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/widgets/social_login_buttons.dart';

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

  bool _isLoading = false;

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

  Future<void> _onGooglePressed() async {
    setState(() => _isLoading = true);
    try {
      final result = await getIt<GoogleAuthService>().signIn();
      if (result == null) return; // user cancelled

      if (!mounted) return;
      context.read<RegisterCubit>().fillFromGoogleAccount(
            firstName: result.firstName,
            lastName: result.lastName,
            email: result.email,
          );

      _navigateToNextStep();
    } catch (e) {
      if (!mounted) return;
      CustomSnackBar.error(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onFacebookPressed() {
    // TODO(auth): Implement Facebook Sign-Up
  }

  void _onApplePressed() {
    // TODO(auth): Implement Apple Sign-Up
  }

  void _onLoginPressed() {
    // Navigate back to login screen if needed
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.register,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RegisterHeader(),
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
                        onAppleTap: _onApplePressed,
                        isGoogleLoading: _isLoading,
                      ),
                      const AppSizedBox(height: AppSize.s20),
                      RegisterSubmitButton(
                        isLoading: _isLoading,
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
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/cubit/login_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/cubit/login_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/cubit/login_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/widgets/login_submit_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/widgets/social_login_buttons.dart';
import '../../../../../config/routes/routes.dart';
import '../../../../../core/layout/app_padding.dart';
import '../../../../../core/layout/app_size.dart';
import '../../../../../core/localization_constants/auth_constants.dart';
import '../../../../../core/resources/app_png.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/app_validator.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/register_redirect_row.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().doEvent(
      SubmitLoginEvent(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  void _onGooglePressed() {
    context.read<LoginCubit>().doEvent(GoogleLoginEvent());
  }

  void _onFacebookPressed() {
    context.read<LoginCubit>().doEvent(FacebookLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.login,
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            previous.loginState != current.loginState,
        listener: (context, state) {
          if (state.loginState.errorMessage != null) {
            CustomSnackBar.error(context, state.loginState.errorMessage!);
          }
          if (state.loginState.data != null) {
            CustomSnackBar.success(context, 'Login Successfully!');

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.appSections,
              (route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSizedBox(height: AppSize.s20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        AppPng.logo,
                        height: AppSize.s100,
                        width: AppSize.s100,
                      ),
                    ),
                    Text(
                      AuthConstants.heyThere,
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.textPrimary,
                        fontSize: FontSizeManager.s18,
                      ),
                    ),
                    Text(
                      AuthConstants.welcomeBack,
                      style: getBoldStyle(
                        context: context,
                        color: AppColors.textPrimary,
                        fontSize: FontSizeManager.s20,
                      ),
                    ),
                  ],
                ),
                const AppSizedBox(height: AppSize.s20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p4,
                  ),
                  child: CustomContainer(
                    borderRadius: AppSize.borderRadiusLarge,
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: Column(
                      children: [
                        Text(
                          AuthConstants.login,
                          style: getBoldStyle(
                            context: context,
                            color: AppColors.textPrimary,
                            fontSize: FontSizeManager.s24,
                          ),
                        ),
                        const AppSizedBox(height: AppSize.s20),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.email_outlined),
                          controller: emailController,
                          hintText: AuthConstants.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator.email,
                        ),
                        const AppSizedBox(height: AppSize.s12),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.lock_outline),
                          controller: passwordController,
                          hintText: AuthConstants.password,
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidator.password,
                          isPassword: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.forgetPassword,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AuthConstants.forgetPassword,
                              style:
                                  getRegularStyle(
                                    context: context,
                                    color: AppColors.primary,
                                    fontSize: FontSizeManager.s14,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary,
                                  ),
                            ),
                          ),
                        ),
                        const AuthOrDivider(),
                        const AppSizedBox(height: AppSize.s20),
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.isGoogleLoginLoading !=
                                  current.isGoogleLoginLoading ||
                              previous.isFacebookLoginLoading !=
                                  current.isFacebookLoginLoading,
                          builder: (context, state) {
                            return SocialLoginButtons(
                              onFacebookTap: _onFacebookPressed,
                              onGoogleTap: _onGooglePressed,
                              onAppleTap: () {
                                CustomSnackBar.info(
                                  context,
                                  AuthConstants.appleLoginUnavailable,
                                );
                              },
                              isGoogleLoading: state.isGoogleLoginLoading,
                              isFacebookLoading: state.isFacebookLoginLoading,
                            );
                          },
                        ),
                        const AppSizedBox(height: AppSize.s20),
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.isEmailLoginLoading !=
                              current.isEmailLoginLoading,
                          builder: (context, state) {
                            return LoginSubmitButton(
                              isLoading: state.isEmailLoginLoading,
                              onTap: _onLoginPressed,
                            );
                          },
                        ),
                        const AppSizedBox(height: AppSize.s20),
                        LoginRedirectRow(
                          onLoginTap: () {
                            Navigator.pushNamed(context, Routes.register);
                          },
                        ),
                      ],
                    ),
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

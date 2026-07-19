import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/cubit/login_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/intent/login_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/state/login_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/widgets/login_submit_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/widgets/social_login_buttons.dart';
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

    context.read<LoginCubit>().handleLoginIntent(
      SubmitLoginIntent(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.login,
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.loginState != current.loginState,
        listener: (context, state) {
          if (state.loginState.errorMessage != null) {
            CustomSnackBar.error(context, state.loginState.errorMessage!);
          }
          if (state.loginState.data != null) {
            CustomSnackBar.success(context, 'Login Successfully!');
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p32,
                          horizontal: AppPadding.p16,
                        ),
                        child: Column(
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
                            const AppSizedBox(height: AppSize.s0),
                          ],
                        ),
                      ),
                      CustomContainer(
                        blur: 5,
                        borderRadius: AppSize.borderRadiusLarge,
                        width: double.infinity,
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AuthConstants.forgetPassword,
                                  style: getRegularStyle(
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
                            const AppSizedBox(
                              height: AppSize.s10,
                            ),
                            SocialLoginButtons(
                              onFacebookTap: () {},
                              onGoogleTap: () {},
                              onAppleTap: () {},
                            ),
                            const AppSizedBox(height: AppSize.s20),
                            BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (previous, current) => previous.loginState.isLoading != current.loginState.isLoading,
                              builder: (context, state) {
                                return LoginSubmitButton(
                                  isLoading: state.loginState.isLoading,
                                  onTap: _onLoginPressed,
                                );
                              },
                            ),
                            const AppSizedBox(height: AppSize.s20),
                            LoginRedirectRow(
                              onLoginTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
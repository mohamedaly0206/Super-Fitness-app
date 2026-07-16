import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/views/register_age_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/views/register_gender_view.dart';

class MainRegisterView extends StatelessWidget {
  MainRegisterView({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: CustomScaffold(
        background: Backgrounds.register,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppSizedBox(height: AppSize.s46),
              Image.asset(
                AppPng.logo,
                height: AppSize.s100,
                width: AppSize.s100,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    RegisterGenderView(pageController: pageController),
                    RegisterAgeView(pageController: pageController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

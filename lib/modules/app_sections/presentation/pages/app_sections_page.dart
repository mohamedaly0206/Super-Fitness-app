import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/pages/home_page.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/pages/workouts_page.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/pages/profile_page.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppSectionsCubit>()),
        BlocProvider(
          create: (_) => getIt<HomeCubit>()
            ..doEvent(GetRandomMusclesEvent())
            ..doEvent(GetLevelsEvent())
            ..doEvent(GetMuscleGroupsEvent())
            ..doEvent(GetFoodCategoriesEvent()),
        ),
        BlocProvider(create: (_) => getIt<WorkoutsCubit>()),
      ],
      child: const _AppSectionsView(),
    );
  }
}

class _AppSectionsView extends StatelessWidget {
  const _AppSectionsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSectionsCubit, AppSectionsState>(
      builder: (context, state) {
        final cubit = context.read<AppSectionsCubit>();
        final currentIndex = state is AppSectionsChanged
            ? state.currentIndex
            : 0;

        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              IndexedStack(
                index: currentIndex,
                children: [
                  const HomePage(),
                  const WorkoutsPage(),
                  const SizedBox.shrink(),
                  const ProfilePage(),
                ],
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    color: AppColors.navBarBackground,
                    child: CustomBottomNavBar(
                      selectedIndex: currentIndex,
                      onItemTapped: cubit.changeSection,
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.navBarBackground,
        );
      },
    );
  }
}

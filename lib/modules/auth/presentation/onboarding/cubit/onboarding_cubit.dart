import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/onboarding_item.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final PageController pageController = PageController();
  List<OnboardingItem> get items => onboardingItems;

  void doEvent(OnboardingEvent event) {
    switch (event) {
      case NextPressedEvent():
        _next();
        break;

      case BackPressedEvent():
        _back();
        break;

      case SkipPressedEvent():
        _skip();
        break;

      case PageChangedEvent():
        emit(state.copyWith(currentPage: event.index));
        break;

      case FinishPressedEvent():
        emit(state.copyWith(navigateToLogin: true));
        break;
    }
  }

  void _next() {
    if (state.currentPage < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _back() {
    if (state.currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    emit(state.copyWith(navigateToLogin: true));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}

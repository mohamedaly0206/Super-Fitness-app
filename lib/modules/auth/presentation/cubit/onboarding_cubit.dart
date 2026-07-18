import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/onboarding_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/onboarding_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/onboarding_item.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final PageController pageController = PageController();
  List<OnboardingItem> get items => onboardingItems;

  void doIntent(OnboardingIntent intent) {
    switch (intent) {
      case NextPressedIntent():
        _next();
        break;

      case BackPressedIntent():
        _back();
        break;

      case SkipPressedIntent():
        _skip();
        break;

      case PageChangedIntent():
        emit(state.copyWith(currentPage: intent.index));
        break;

      case FinishPressedIntent():
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
    pageController.animateToPage(
      items.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}

class OnboardingState {
  final int currentPage;
  final bool navigateToLogin;

  const OnboardingState({this.currentPage = 0, this.navigateToLogin = false});

  bool get isFirstPage => currentPage == 0;

  bool get isLastPage => currentPage == 2;

  OnboardingState copyWith({int? currentPage, bool? navigateToLogin}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      navigateToLogin: navigateToLogin ?? false,
    );
  }
}

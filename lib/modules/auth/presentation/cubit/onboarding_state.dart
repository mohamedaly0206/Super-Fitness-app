class OnboardingState {
  final int currentPage;

  const OnboardingState({this.currentPage = 0});

  bool get isFirstPage => currentPage == 0;

  bool get isLastPage => currentPage == 2;

  OnboardingState copyWith({int? currentPage}) {
    return OnboardingState(currentPage: currentPage ?? this.currentPage);
  }
}

sealed class OnboardingEvent {
  const OnboardingEvent();
}

class NextPressedEvent extends OnboardingEvent {
  const NextPressedEvent();
}

class BackPressedEvent extends OnboardingEvent {
  const BackPressedEvent();
}

class SkipPressedEvent extends OnboardingEvent {
  const SkipPressedEvent();
}

class PageChangedEvent extends OnboardingEvent {
  final int index;

  const PageChangedEvent(this.index);
}

class FinishPressedEvent extends OnboardingEvent {
  const FinishPressedEvent();
}

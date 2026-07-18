sealed class OnboardingIntent {
  const OnboardingIntent();
}

class NextPressedIntent extends OnboardingIntent {
  const NextPressedIntent();
}

class BackPressedIntent extends OnboardingIntent {
  const BackPressedIntent();
}

class SkipPressedIntent extends OnboardingIntent {
  const SkipPressedIntent();
}

class PageChangedIntent extends OnboardingIntent {
  final int index;

  const PageChangedIntent(this.index);
}

class FinishPressedIntent extends OnboardingIntent {
  const FinishPressedIntent();
}

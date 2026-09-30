sealed class AppSectionsEvent {
  const AppSectionsEvent();
}

class ChangeSectionEvent extends AppSectionsEvent {
  final int index;

  const ChangeSectionEvent(this.index);
}

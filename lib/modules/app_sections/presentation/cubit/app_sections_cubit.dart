import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_sections_event.dart';
import 'app_sections_state.dart';

@injectable
class AppSectionsCubit extends Cubit<AppSectionsState> {
  AppSectionsCubit() : super(AppSectionsInitial());

  void doEvent(AppSectionsEvent event) {
    switch (event) {
      case ChangeSectionEvent():
        emit(AppSectionsChanged(currentIndex: event.index));
        break;
    }
  }
}

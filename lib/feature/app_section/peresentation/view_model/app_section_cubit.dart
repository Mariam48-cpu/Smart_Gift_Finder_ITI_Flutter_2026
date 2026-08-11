import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view_model/app_section_states.dart';

class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(AppSectionInitialState());

  int currentIndex = 0;

  void changeTab(int index) {
    if (currentIndex == index) return;

    currentIndex = index;
    emit(AppSectionChangeTabState());
  }
}

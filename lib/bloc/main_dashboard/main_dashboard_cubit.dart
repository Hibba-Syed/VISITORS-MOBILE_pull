import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/resource/constants/app_constants.dart';

part 'main_dashboard_state.dart';

class MainDashboardCubit extends Cubit<MainDashboardState> {
  MainDashboardCubit() : super(const MainDashboardState());
  void onChangeSelectedIndex(int index) {
    if (index == AppConstants.dashboardIndex) {
      emit(state.copyWith(
        selectedIndex: index,
        navigationHistory: [],
      ));
    } else {
      final history = List<int>.from(state.navigationHistory);
      history.add(state.selectedIndex);

      emit(
        state.copyWith(
          selectedIndex: index,
          navigationHistory: history,
        ),
      );
    }
  }
  void resetDashboard() {
    emit(state.copyWith(
      selectedIndex: AppConstants.dashboardIndex,
      navigationHistory: [],
    ));
  }

  void onBackButtonPressed() {
    final history = List<int>.from(state.navigationHistory);
    if (history.isNotEmpty) {
      final lastIndex = history.removeLast();
      emit(state.copyWith(
        selectedIndex: lastIndex,
        navigationHistory: history,
      ));
    }
  }
}

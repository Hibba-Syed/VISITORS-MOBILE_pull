part of 'main_dashboard_cubit.dart';

class MainDashboardState {
  final int selectedIndex;
  final bool isLoading;
  const MainDashboardState({
    this.selectedIndex = AppConstants.dashboardIndex,
    this.isLoading = false,
  });
  MainDashboardState copyWith({
    int? selectedIndex,
    bool? isLoading,
  }) {
    return MainDashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

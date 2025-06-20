part of 'main_dashboard_cubit.dart';

class MainDashboardState {
  final int selectedIndex;
  final bool isLoading;
  final List<int> navigationHistory;
  const MainDashboardState({
    this.selectedIndex = AppConstants.dashboardIndex,
    this.isLoading = false,
    this.navigationHistory = const [],
  });
  MainDashboardState copyWith({
    int? selectedIndex,
    bool? isLoading,
    List<int>? navigationHistory,
  }) {
    return MainDashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      navigationHistory: navigationHistory ?? this.navigationHistory
    );
  }
}

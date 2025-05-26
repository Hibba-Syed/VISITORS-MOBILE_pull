part of 'device_decider_cubit.dart';

class DeviceDeciderState {
  final int selectedIndex;
  final bool isLoading;
  final List<int> navigationHistory;
  const DeviceDeciderState({
    this.selectedIndex = AppConstants.dashboardIndex,
    this.isLoading = false,
    this.navigationHistory = const [],
  });
  DeviceDeciderState copyWith({
    int? selectedIndex,
    bool? isLoading,
    List<int>? navigationHistory,
  }) {
    return DeviceDeciderState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      navigationHistory: navigationHistory ?? this.navigationHistory
    );
  }
}

part of 'device_decider_cubit.dart';

class DeviceDeciderState {
  final int selectedIndex;
  final bool isLoading;
  const DeviceDeciderState({
    this.selectedIndex = AppConstants.dashboardIndex,
    this.isLoading = false,
  });
  DeviceDeciderState copyWith({
    int? selectedIndex,
    bool? isLoading,
  }) {
    return DeviceDeciderState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

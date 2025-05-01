part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
   ProfileRecord? profileRecord;
   DashboardState({
    this.isLoading = false,
    this.profileRecord
  });
  DashboardState copyWith({
    bool? isLoading,
    ProfileRecord? profileRecord,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      profileRecord: profileRecord ?? this.profileRecord,
    );
  }
}

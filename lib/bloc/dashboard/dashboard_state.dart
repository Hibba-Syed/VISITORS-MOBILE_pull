part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
   ProfileRecord? profileRecord;
  final int page;
  List<CheckInsRecord>? checkInsRecord;
   DashboardState({
    this.isLoading = false,
    this.profileRecord,
     this.page = 1,
     this.checkInsRecord,
  });
  DashboardState copyWith({
    bool? isLoading,
    ProfileRecord? profileRecord,
    int? page,
    List<CheckInsRecord>? checkInsRecord,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      profileRecord: profileRecord ?? this.profileRecord,
        page: page ?? this.page,
        checkInsRecord: checkInsRecord ?? this.checkInsRecord
    );
  }
}

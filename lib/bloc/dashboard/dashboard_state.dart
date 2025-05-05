part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
  final bool? isCheckInLoading;
   ProfileRecord? profileRecord;
  final int page;
  List<CheckInsModel>? checkInsModel;
   DashboardState({
    this.isLoading = false,
    this.isCheckInLoading = false,
    this.profileRecord,
     this.page = 1,
     this.checkInsModel,
  });
  DashboardState copyWith({
    bool? isLoading,
    bool? isCheckInLoading,
    ProfileRecord? profileRecord,
    int? page,
    List<CheckInsModel>? checkInsRecord,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
        isCheckInLoading: isCheckInLoading ?? this.isCheckInLoading,
      profileRecord: profileRecord ?? this.profileRecord,
        page: page ?? this.page,
        checkInsModel: checkInsRecord ?? this.checkInsModel
    );
  }
}

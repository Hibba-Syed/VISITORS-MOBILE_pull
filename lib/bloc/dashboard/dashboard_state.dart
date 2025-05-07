part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
  final bool? isCheckInLoading;
  final bool? isCountLoading;
  ProfileRecord? profileRecord;
  final int page;
  List<CheckInModel>? checkInsModel;
  CountModel? countModel;
  DashboardState({
    this.isLoading = false,
    this.isCheckInLoading = false,
    this.isCountLoading = false,
    this.profileRecord,
    this.page = 1,
    this.checkInsModel,
    this.countModel,
  });
  DashboardState copyWith({
    bool? isLoading,
    bool? isCheckInLoading,
    bool? isCountLoading,
    ProfileRecord? profileRecord,
    int? page,
    List<CheckInModel>? checkInsModel,
    CountModel? countModel,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isCheckInLoading: isCheckInLoading ?? this.isCheckInLoading,
      isCountLoading: isCountLoading ?? this.isCountLoading,
      profileRecord: profileRecord ?? this.profileRecord,
      page: page ?? this.page,
      checkInsModel: checkInsModel ?? this.checkInsModel,
      countModel: countModel ?? this.countModel,
    );
  }
}

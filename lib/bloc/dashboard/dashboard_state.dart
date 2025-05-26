part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
  final bool? isCheckInLoading;
  final bool? isCountLoading;
  final bool? isServicesLoading;
  final bool? isWorkOrderLoading;
  ProfileRecord? profileRecord;
  final int page;
  List<CheckInModel>? checkInsModel;
  List<ServiceModel>? serviceModel;
  List<WorkOrderModel>? workOrderModel;
  List<CheckOutModel>? checkOutModel;
  CountModel? countModel;
  DashboardState(
      {this.isLoading = false,
      this.isCheckInLoading = false,
      this.isCountLoading = false,
      this.isServicesLoading = false,
      this.profileRecord,
      this.page = 1,
      this.checkInsModel,
      this.countModel,
      this.serviceModel,
      this.isWorkOrderLoading,
      this.workOrderModel,
      this.checkOutModel,
   });
  DashboardState copyWith({
    bool? isLoading,
    bool? isCheckInLoading,
    bool? isCountLoading,
    bool? isServicesLoading,
    bool? isWorkOrderLoading,
    ProfileRecord? profileRecord,
    int? page,
    List<CheckInModel>? checkInsModel,
    List<ServiceModel>? serviceModel,
    List<WorkOrderModel>? workOrderModel,
    List<CheckOutModel>? checkOutModel,
    CountModel? countModel,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isCheckInLoading: isCheckInLoading ?? this.isCheckInLoading,
      isCountLoading: isCountLoading ?? this.isCountLoading,
      isServicesLoading: isServicesLoading ?? this.isServicesLoading,
      isWorkOrderLoading: isWorkOrderLoading ?? this.isWorkOrderLoading,
      profileRecord: profileRecord ?? this.profileRecord,
      page: page ?? this.page,
      checkInsModel: checkInsModel ?? this.checkInsModel,
      countModel: countModel ?? this.countModel,
      serviceModel: serviceModel ?? this.serviceModel,
      workOrderModel: workOrderModel ?? this.workOrderModel,
      checkOutModel: checkOutModel ?? this.checkOutModel,

    );
  }
}

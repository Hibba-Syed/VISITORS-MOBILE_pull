part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isLoading;
  final bool? isCheckInLoading;
  final bool? isCountLoading;
  final bool? isServicesLoading;
  final bool? isWorkOrderLoading;
  final bool? isVisitorPassLoading;
  final bool? isCheckOutVisitor;
  final bool? isVisitorPassesCountLoading;
  final ProfileRecord? profileRecord;
  final int page;
  final List<CheckInModel>? checkInsModel;
  final List<ServiceModel>? serviceModel;
  final List<WorkOrderModel>? workOrderModel;
  final List<CheckOutVisitors>? checkOutModel;
  final List<VisitorPasses>? visitorPasses;
  final List<CheckOutVisitors>? checkOutVisitors;
  final VisitorPassesCount? visitorPassesCount;
  final CountModel? countModel;
  DashboardState({
    this.isLoading = false,
    this.isCheckInLoading = false,
    this.isCountLoading = false,
    this.isServicesLoading = false,
    this.isVisitorPassLoading = false,
    this.isVisitorPassesCountLoading = false,
    this.profileRecord,
    this.page = 1,
    this.checkInsModel,
    this.countModel,
    this.serviceModel,
    this.isWorkOrderLoading,
    this.workOrderModel,
    this.checkOutModel,
    this.visitorPasses,
    this.isCheckOutVisitor,
    this.checkOutVisitors,
    this.visitorPassesCount,
  });
  DashboardState copyWith({
    bool? isLoading,
    bool? isCheckInLoading,
    bool? isCountLoading,
    bool? isServicesLoading,
    bool? isWorkOrderLoading,
    bool? isVisitorPassLoading,
    bool? isCheckOutVisitor,
    bool? isVisitorPassesCountLoading,
    ProfileRecord? profileRecord,
    int? page,
    List<CheckInModel>? checkInsModel,
    List<ServiceModel>? serviceModel,
    List<WorkOrderModel>? workOrderModel,
    List<CheckOutVisitors>? checkOutModel,
    List<VisitorPasses>? visitorPasses,
    VisitorPassesCount? visitorPassesCount,
    List<CheckOutVisitors>? checkOutVisitors,
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
        visitorPasses: visitorPasses ?? this.visitorPasses,
        isVisitorPassLoading: isVisitorPassLoading ?? this.isVisitorPassLoading,
        isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
        checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
        isVisitorPassesCountLoading: isVisitorPassesCountLoading ?? this.isVisitorPassesCountLoading,
        visitorPassesCount: visitorPassesCount ?? this.visitorPassesCount,
    );
  }
}

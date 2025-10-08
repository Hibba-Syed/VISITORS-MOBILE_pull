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
  final List<CheckInModel>? checkIns;
  final List<ServiceModel>? services;
  final List<WorkOrderModel>? workOrders;
  final List<CheckOutModel>? checkOuts;
  final List<VisitorPassModel>? visitorPasses;
  final List<CheckOutModel>? checkOutVisitors;
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
    this.checkIns,
    this.countModel,
    this.services,
    this.isWorkOrderLoading,
    this.workOrders,
    this.checkOuts,
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
    List<CheckInModel>? checkIns,
    List<ServiceModel>? services,
    List<WorkOrderModel>? workOrders,
    List<CheckOutModel>? checkOuts,
    List<VisitorPassModel>? visitorPasses,
    VisitorPassesCount? visitorPassesCount,
    List<CheckOutModel>? checkOutVisitors,
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
      checkIns: checkIns ?? this.checkIns,
      countModel: countModel ?? this.countModel,
      services: services ?? this.services,
      workOrders: workOrders ?? this.workOrders,
      checkOuts: checkOuts ?? this.checkOuts,
      visitorPasses: visitorPasses ?? this.visitorPasses,
      isVisitorPassLoading: isVisitorPassLoading ?? this.isVisitorPassLoading,
      isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
      checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
      isVisitorPassesCountLoading:
          isVisitorPassesCountLoading ?? this.isVisitorPassesCountLoading,
      visitorPassesCount: visitorPassesCount ?? this.visitorPassesCount,
    );
  }
}

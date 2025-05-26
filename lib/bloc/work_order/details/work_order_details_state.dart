part of 'work_order_details_cubit.dart';

class WorkOrderDetailsState {
  final bool isLoading;
  final bool isAddLogLoading;
  WorkOrderDetailsModel? workOrderDetailsModel;
  WorkOrderDetailsState({
    this.isLoading = false,
    this.workOrderDetailsModel,
    this.isAddLogLoading = false,
  });
  WorkOrderDetailsState copyWith({
    bool? isLoading,
    bool? isAddLogLoading,
    WorkOrderDetailsModel? workOrderDetailsModel,
  }) {
    return WorkOrderDetailsState(
      isLoading: isLoading ?? this.isLoading,
      workOrderDetailsModel:
          workOrderDetailsModel ?? this.workOrderDetailsModel,
      isAddLogLoading: isAddLogLoading ?? this.isAddLogLoading,
    );
  }
}

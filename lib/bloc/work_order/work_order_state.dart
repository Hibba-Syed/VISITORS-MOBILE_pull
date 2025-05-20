part of 'work_order_cubit.dart';

class WorkOrderState {
  final int? page;
  final bool isLoading;
  final bool loadMore;
  final String? searchKeyword;
  final int? isAwarded;
  final bool isVendorLoading;
  List<WorkOrderModel>? workOrderModel;
  List<VendorModel>? vendors;
  final VendorModel? selectedVendor;
  final String? selectedType;
  WorkOrderState({
    this.isLoading = false,
    this.loadMore = false,
    this.workOrderModel,
    this.searchKeyword,
    this.isAwarded,
    this.isVendorLoading = false,
    this.vendors,
    this.selectedVendor,
    this.page = 1,
    this.selectedType,
  });
  WorkOrderState copyWith({
    int? page,
    bool? isLoading,
    bool? loadMore,
    String? searchKeyword,
    int? isAwarded,
    bool? isVendorLoading,
    List<WorkOrderModel>? workOrderModel,
    List<VendorModel>? vendors,
    VendorModel? selectedVendor,
    String? selectedType,
  }) {
    return WorkOrderState(
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        loadMore: loadMore ?? this.loadMore,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        workOrderModel: workOrderModel ?? this.workOrderModel,
        isAwarded: isAwarded ?? this.isAwarded,
        isVendorLoading: isVendorLoading ?? this.isVendorLoading,
        vendors: vendors ?? this.vendors,
        selectedVendor: selectedVendor ?? this.selectedVendor,
        selectedType: selectedType ?? this.selectedType);
  }
}

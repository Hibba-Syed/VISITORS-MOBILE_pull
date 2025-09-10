part of 'work_order_cubit.dart';

class WorkOrderState {
  final int page;
  final bool isLoading;
  final bool loadMore;
  final String? searchKeyword;
  final int? isAwarded;
  final bool isVendorLoading;
  final List<WorkOrderModel>? workOrders;
  final List<VendorModel>? vendors;
  final VendorModel? selectedVendor;
  final TypeModel? selectedType;

  const WorkOrderState({
    this.isLoading = false,
    this.loadMore = false,
    this.workOrders,
    this.searchKeyword,
    this.isAwarded,
    this.isVendorLoading = false,
    this.vendors,
    this.selectedVendor,
    this.page = 1,
    this.selectedType,
  });

  static const _sentinel = Object();

  WorkOrderState copyWith({
    int? page,
    bool? isLoading,
    bool? loadMore,
    Object? searchKeyword = _sentinel,
    int? isAwarded,
    bool? isVendorLoading,
    List<WorkOrderModel>? workOrders,
    List<VendorModel>? vendors,
    Object? selectedVendor = _sentinel,
    Object? selectedType = _sentinel,
  }) {
    return WorkOrderState(
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      loadMore: loadMore ?? this.loadMore,
      searchKeyword: identical(searchKeyword, _sentinel)
          ? this.searchKeyword
          : searchKeyword as String?,
      workOrders: workOrders ?? this.workOrders,
      isAwarded: isAwarded ?? this.isAwarded,
      isVendorLoading: isVendorLoading ?? this.isVendorLoading,
      vendors: vendors ?? this.vendors,
      selectedVendor: identical(selectedVendor, _sentinel)
          ? this.selectedVendor
          : selectedVendor as VendorModel?,
      selectedType: identical(selectedType, _sentinel)
          ? this.selectedType
          : selectedType as TypeModel?,
    );
  }
}

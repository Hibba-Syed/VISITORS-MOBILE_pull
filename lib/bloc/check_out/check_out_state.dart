part of 'check_out_cubit.dart';

class CheckOutState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final bool isCheckOutLoading;
  final int page;
  List<CheckOutModel>? checkOutModel;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final String? dateRang;
  CheckOutState({
    this.isLoading = false,
    this.loadMore = false,
    this.isUnitLoading = false,
    this.isVendorLoading = false,
    this.page = 1,
    this.checkOutModel,
    this.units,
    this.vendors,
    this.isCheckOutAllLoading = false,
    this.dateRang,
    this.isCheckOutLoading = false,
  });
  CheckOutState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isVendorLoading,
    bool? isCheckOutAllLoading,
    bool? isCheckOutLoading,
    bool? loadMore,
    int? page,
    List<CheckOutModel>? checkOutModel,
    List<UnitModel>? units,
    List<VendorModel>? vendors,
    final String? dateRang,
  }) {
    return CheckOutState(
        isLoading: isLoading ?? this.isLoading,
        isUnitLoading: isUnitLoading ?? this.isUnitLoading,
        isVendorLoading: isVendorLoading ?? this.isVendorLoading,
        isCheckOutAllLoading: isCheckOutAllLoading ?? this.isCheckOutAllLoading,
        isCheckOutLoading: isCheckOutLoading ?? this.isCheckOutLoading,
        loadMore: loadMore ?? this.loadMore,
        page: page ?? this.page,
        dateRang: dateRang ?? this.dateRang,
        vendors: vendors ?? this.vendors,
        units: units ?? this.units,
        checkOutModel: checkOutModel ?? this.checkOutModel);
  }
}

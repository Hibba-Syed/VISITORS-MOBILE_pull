part of 'check_out_cubit.dart';

class CheckOutState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final bool isCheckOutLoading;
  final int page;
  List<CheckOutVisitors>? checkOutVisitors;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final String? dateRang;
  final String? selectedRang;
  final TypeModel? selectedType;
  final UnitModel? selectedUnit;
  final VendorModel? selectedVendor;
  final String? searchKeyword;
  CheckOutState({
    this.isLoading = false,
    this.loadMore = false,
    this.isUnitLoading = false,
    this.isVendorLoading = false,
    this.page = 1,
    this.checkOutVisitors,
    this.units,
    this.vendors,
    this.isCheckOutAllLoading = false,
    this.dateRang,
    this.selectedRang,
    this.isCheckOutLoading = false,
    this.selectedType,
    this.selectedUnit,
    this.selectedVendor,
    this.searchKeyword,
  });
  CheckOutState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isVendorLoading,
    bool? isCheckOutAllLoading,
    bool? isCheckOutLoading,
    bool? loadMore,
    int? page,
    List<CheckOutVisitors>? checkOutVisitors,
    List<UnitModel>? units,
    List<VendorModel>? vendors,
    String? dateRang,
    String? selectedRang,
    TypeModel? selectedType,
    UnitModel? selectedUnit,
    VendorModel? selectedVendor,
    String? searchKeyword,
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
        checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
        selectedRang: selectedRang ?? this.selectedRang,
        selectedType: selectedType ?? this.selectedType,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        selectedVendor: selectedVendor ?? this.selectedVendor,
        searchKeyword: searchKeyword ?? this.searchKeyword);
  }
}

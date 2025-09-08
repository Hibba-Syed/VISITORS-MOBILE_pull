part of 'check_out_cubit.dart';

class CheckOutState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final bool isCheckOutLoading;
  final int page;
  final List<CheckOutVisitor>? checkOutVisitors;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final DateTimeRange? dateRang;
  final String? selectedRange;
  final TypeModel? selectedType;
  final UnitModel? selectedUnit;
  final VendorModel? selectedVendor;
  final String? searchKeyword;

  const CheckOutState({
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
    this.selectedRange,
    this.isCheckOutLoading = false,
    this.selectedType,
    this.selectedUnit,
    this.selectedVendor,
    this.searchKeyword,
  });

  static const _sentinel = Object();

  CheckOutState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isVendorLoading,
    bool? isCheckOutAllLoading,
    bool? isCheckOutLoading,
    bool? loadMore,
    int? page,
    List<CheckOutVisitor>? checkOutVisitors,
    List<UnitModel>? units,
    List<VendorModel>? vendors,
    Object? dateRang = _sentinel,
    Object? selectedRange = _sentinel,
    Object? selectedType = _sentinel,
    Object? selectedUnit = _sentinel,
    Object? selectedVendor = _sentinel,
    Object? searchKeyword = _sentinel,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      isVendorLoading: isVendorLoading ?? this.isVendorLoading,
      isCheckOutAllLoading: isCheckOutAllLoading ?? this.isCheckOutAllLoading,
      isCheckOutLoading: isCheckOutLoading ?? this.isCheckOutLoading,
      loadMore: loadMore ?? this.loadMore,
      page: page ?? this.page,
      checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
      vendors: vendors ?? this.vendors,
      units: units ?? this.units,

      // 👇 sentinel handling
      dateRang: identical(dateRang, _sentinel)
          ? this.dateRang
          : dateRang as DateTimeRange?,
      selectedRange: identical(selectedRange, _sentinel)
          ? this.selectedRange
          : selectedRange as String?,
      selectedType: identical(selectedType, _sentinel)
          ? this.selectedType
          : selectedType as TypeModel?,
      selectedUnit: identical(selectedUnit, _sentinel)
          ? this.selectedUnit
          : selectedUnit as UnitModel?,
      selectedVendor: identical(selectedVendor, _sentinel)
          ? this.selectedVendor
          : selectedVendor as VendorModel?,
      searchKeyword: identical(searchKeyword, _sentinel)
          ? this.searchKeyword
          : searchKeyword as String?,
    );
  }
}

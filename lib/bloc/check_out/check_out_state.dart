part of 'check_out_cubit.dart';

class CheckOutState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final bool isCheckOutLoading;
  final int page;
  final List<CheckOutModel>? checkOuts;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final DateTimeRange? selectedDateRange;
  final RangeModel? selectedRange;
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
    this.checkOuts,
    this.units,
    this.vendors,
    this.isCheckOutAllLoading = false,
    this.selectedDateRange,
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
    List<CheckOutModel>? checkOuts,
    List<UnitModel>? units,
    List<VendorModel>? vendors,
    Object? selectedDateRange = _sentinel,
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
      checkOuts: checkOuts ?? this.checkOuts,
      vendors: vendors ?? this.vendors,
      units: units ?? this.units,

      // 👇 sentinel handling
      selectedDateRange: identical(selectedDateRange, _sentinel)
          ? this.selectedDateRange
          : selectedDateRange as DateTimeRange?,
      selectedRange: identical(selectedRange, _sentinel)
          ? this.selectedRange
          : selectedRange as RangeModel?,
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

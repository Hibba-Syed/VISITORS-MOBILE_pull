part of 'check_ins_cubit.dart';

class CheckInsState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool isCheckOutVisitor;
  final bool loadMore;
  final int page;
  final int? serviceableId;
  final List<CheckInModel>? checkInModel;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final UnitModel? selectedUnit;
  final VendorModel? selectedVendor;
  final DateTimeRange? dateRange;
  final String? selectedRange;
  final String? searchKeyword;
  final TypeModel? selectedVisitorType;
  final List<CheckOutVisitor>? checkOutVisitors;

  const CheckInsState({
    this.isLoading = false,
    this.loadMore = false,
    this.isUnitLoading = false,
    this.isVendorLoading = false,
    this.isCheckOutVisitor = false,
    this.page = 1,
    this.checkInModel,
    this.units,
    this.vendors,
    this.selectedUnit,
    this.selectedVendor,
    this.isCheckOutAllLoading = false,
    this.dateRange,
    this.selectedRange,
    this.searchKeyword,
    this.serviceableId,
    this.checkOutVisitors,
    this.selectedVisitorType,
  });

  static const _sentinel = Object();

  CheckInsState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isVendorLoading,
    bool? isCheckOutAllLoading,
    bool? loadMore,
    bool? isCheckOutVisitor,
    int? page,
    List<CheckInModel>? checkInModel,
    List<UnitModel>? units,
    List<VendorModel>? vendors,
    Object? selectedVisitorType = _sentinel,
    Object? selectedUnit = _sentinel,
    Object? selectedVendor = _sentinel,
    Object? dateRange = _sentinel,
    Object? selectedRange = _sentinel,
    Object? searchKeyword = _sentinel,
    Object? serviceableId = _sentinel,
    List<CheckOutVisitor>? checkOutVisitors,
  }) {
    return CheckInsState(
      isLoading: isLoading ?? this.isLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      isVendorLoading: isVendorLoading ?? this.isVendorLoading,
      isCheckOutAllLoading: isCheckOutAllLoading ?? this.isCheckOutAllLoading,
      loadMore: loadMore ?? this.loadMore,
      page: page ?? this.page,
      checkInModel: checkInModel ?? this.checkInModel,
      vendors: vendors ?? this.vendors,
      units: units ?? this.units,

      // 👇 sentinel handling
      selectedVisitorType: identical(selectedVisitorType, _sentinel)
          ? this.selectedVisitorType
          : selectedVisitorType as TypeModel?,

      selectedUnit: identical(selectedUnit, _sentinel)
          ? this.selectedUnit
          : selectedUnit as UnitModel?,

      selectedVendor: identical(selectedVendor, _sentinel)
          ? this.selectedVendor
          : selectedVendor as VendorModel?,

      dateRange: identical(dateRange, _sentinel)
          ? this.dateRange
          : dateRange as DateTimeRange?,

      selectedRange: identical(selectedRange, _sentinel)
          ? this.selectedRange
          : selectedRange as String?,

      searchKeyword: identical(searchKeyword, _sentinel)
          ? this.searchKeyword
          : searchKeyword as String?,

      serviceableId: identical(serviceableId, _sentinel)
          ? this.serviceableId
          : serviceableId as int?,

      isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
      checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
    );
  }
}


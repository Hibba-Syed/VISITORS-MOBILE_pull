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

  CheckInsState({
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
    this.selectedVisitorType
  });
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
    TypeModel? selectedVisitorType,
    UnitModel? selectedUnit,
    VendorModel? selectedVendor,
    DateTimeRange? dateRange,
    String? selectedRange,
     String? searchKeyword,
     int? serviceableId,
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
        selectedVisitorType: selectedVisitorType ?? this.selectedVisitorType,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        selectedVendor: selectedVendor ?? this.selectedVendor,
        dateRange: dateRange ?? this.dateRange,
        selectedRange: selectedRange ?? this.selectedRange,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        serviceableId: serviceableId ?? this.serviceableId,
        isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
        checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,

    );
  }
}

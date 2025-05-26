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
  List<CheckInModel>? checkInModel;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  final TypeModel? selectedType;
  final UnitModel? selectedUnit;
  final VendorModel? selectedVendor;
  final String? dateRang;
  final String? selectedRang;
  final String? searchKeyword;
  List<CheckOutVisitors>? checkOutVisitors;
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
    this.selectedType,
    this.selectedUnit,
    this.selectedVendor,
    this.isCheckOutAllLoading = false,
    this.dateRang,
    this.selectedRang,
    this.searchKeyword,
    this.serviceableId,
    this.checkOutVisitors,
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
    TypeModel? selectedType,
    UnitModel?selectedUnit,
    VendorModel? selectedVendor,
     String? dateRang,
     String? selectedRang,
     String? searchKeyword,
     int? serviceableId,
    List<CheckOutVisitors>? checkOutVisitors,
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
        selectedType: selectedType ?? this.selectedType,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        selectedVendor: selectedVendor ?? this.selectedVendor,
        dateRang: dateRang ?? this.dateRang,
        selectedRang: selectedRang ?? this.selectedRang,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        serviceableId: serviceableId ?? this.serviceableId,
        isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
        checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
    );
  }
}

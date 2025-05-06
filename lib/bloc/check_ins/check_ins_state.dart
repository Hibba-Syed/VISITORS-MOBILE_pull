part of 'check_ins_cubit.dart';

class CheckInsState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool isVendorLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final int page;
  List<CheckInModel>? checkInModel;
  final List<UnitModel>? units;
  final List<VendorModel>? vendors;
  //final VendorsResponseModel? vendorsModel;
  CheckInsState({
    this.isLoading = false,
    this.loadMore = false,
    this.isUnitLoading = false,
    this.isVendorLoading = false,
    this.page = 1,
    this.checkInModel,
    this.units,
   // this.vendorsModel,
    this.vendors,
    this.isCheckOutAllLoading = false,
  });
  CheckInsState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isVendorLoading,
    bool? isCheckOutAllLoading,
    bool? loadMore,
    int? page,
    List<CheckInModel>? checkInsRecord,
    List<UnitModel>? units,
     List<VendorModel>? vendors,
   // VendorsResponseModel? vendorsModel,
  }) {
    return CheckInsState(
      isLoading: isLoading ?? this.isLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      isVendorLoading: isVendorLoading ?? this.isVendorLoading,
      isCheckOutAllLoading: isCheckOutAllLoading ?? this.isCheckOutAllLoading,
      loadMore: loadMore ?? this.loadMore,
      page: page ?? this.page,
      checkInModel: checkInsRecord ?? this.checkInModel,
      vendors: vendors ?? this.vendors,
      // vendorsModel: vendorsModel ?? this.vendorsModel,
      units: units ?? this.units,
    );
  }
}

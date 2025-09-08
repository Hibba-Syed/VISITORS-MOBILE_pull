part of 'service_cubit.dart';

class ServiceState {
  final bool isLoading;
  final bool isUnitLoading;
  final bool loadMore;
  final bool? isServicesDetailsLoading;
  final int page;
  List<ServiceModel>? serviceModel;
  final String? searchKeyword;
  final TypeModel? selectedType;
  final UnitModel? selectedUnit;
  final List<UnitModel>? units;

  ServiceState({
    this.isLoading = false,
    this.isUnitLoading = false,
    this.isServicesDetailsLoading = false,
    this.page = 1,
    this.serviceModel,
    this.searchKeyword,
    this.loadMore = false,
    this.selectedUnit,
    this.selectedType,
    this.units,
  });
  ServiceState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    bool? isServicesDetailsLoading,
    int? page,
    List<ServiceModel>? serviceModel,
    String? searchKeyword,
    bool? loadMore,
    Object? selectedType = _sentinel,
    Object? selectedUnit = _sentinel,
    Object? selectCheckInTypeList = _sentinel,
    List<UnitModel>? units,
  }) {
    return ServiceState(
      isLoading: isLoading ?? this.isLoading,
      isServicesDetailsLoading:
          isServicesDetailsLoading ?? this.isServicesDetailsLoading,
      page: page ?? this.page,
      serviceModel: serviceModel ?? this.serviceModel,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      loadMore: loadMore ?? this.loadMore,
      selectedType: identical(selectedType, _sentinel)
          ? this.selectedType
          : selectedType as TypeModel?,
      selectedUnit: identical(selectedUnit, _sentinel)
          ? this.selectedUnit
          : selectedUnit as UnitModel?,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      units: units ?? this.units,
    );
  }

// private sentinel to detect “not passed”
  static const _sentinel = Object();
}

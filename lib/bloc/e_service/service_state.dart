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
  final TypeModel? selectCheckInTypeList;
  final UnitModel? selectedUnit;
  final  List<UnitModel>? units;

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
    this.selectCheckInTypeList,
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
    TypeModel? selectedType,
    UnitModel? selectedUnit,
    List<UnitModel>? units,
    TypeModel? selectCheckInTypeList,
  }) {
    return ServiceState(
      isLoading: isLoading ?? this.isLoading,
      isServicesDetailsLoading:
          isServicesDetailsLoading ?? this.isServicesDetailsLoading,
      page: page ?? this.page,
      serviceModel: serviceModel ?? this.serviceModel,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      loadMore: loadMore ?? this.loadMore,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      selectedType: selectedType ?? this.selectedType,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      units: units ?? this.units,
        selectCheckInTypeList: selectCheckInTypeList ?? this.selectCheckInTypeList

    );
  }
}

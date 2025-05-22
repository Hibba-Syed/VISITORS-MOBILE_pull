part of 'visitor_pass_cubit.dart';

class VisitorPassState {
  final bool isLoading;
  final bool loadMore;
  final int page;
  final String? searchKeyword;
  final bool isUnitLoading;
  final List<UnitModel>? units;
  final UnitModel? selectedUnit;
  List<VisitorPassModel>? visitorPassModel;
  VisitorPassState({
    this.isLoading = false,
    this.visitorPassModel,
    this.loadMore = false,
    this.isUnitLoading = false,
    this.page = 1,
    this.searchKeyword,
    this.units,
    this.selectedUnit,
  });
  VisitorPassState copyWith({
    bool? isLoading,
    bool? isUnitLoading,
    List<VisitorPassModel>? visitorPassModel,
    bool? loadMore,
    int? page,
    String? searchKeyword,
    List<UnitModel>? units,
     UnitModel? selectedUnit,
  }) {
    return VisitorPassState(
        isLoading: isLoading ?? this.isLoading,
        isUnitLoading: isUnitLoading ?? this.isUnitLoading,
        page: page ?? this.page,
        loadMore: loadMore ?? this.loadMore,
        visitorPassModel: visitorPassModel ?? this.visitorPassModel,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        units: units ?? this.units,
        selectedUnit: selectedUnit ?? this.selectedUnit
    );
  }
}

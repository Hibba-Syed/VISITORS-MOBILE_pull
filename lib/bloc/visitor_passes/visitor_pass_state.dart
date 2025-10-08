part of 'visitor_pass_cubit.dart';

class VisitorPassState {
  final bool isLoading;
  final bool loadMore;
  final int page;
  final String? searchKeyword;
  final bool isUnitLoading;
  final List<UnitModel>? units;
  final UnitModel? selectedUnit;
  List<VisitorPassModel>? visitorPasses;
  VisitorPassState({
    this.isLoading = false,
    this.visitorPasses,
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
    List<VisitorPassModel>? visitorPasses,
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
        visitorPasses: visitorPasses ?? this.visitorPasses,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        units: units ?? this.units,
        selectedUnit: selectedUnit ?? this.selectedUnit
    );
  }
}

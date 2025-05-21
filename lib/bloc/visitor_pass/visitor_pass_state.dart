part of 'visitor_pass_cubit.dart';


class VisitorPassState {
  final bool isLoading;
  final bool loadMore;
  final int page;
  List<VisitorPassModel>? visitorPassModel;
  VisitorPassState({
    this.isLoading = false,
    this.visitorPassModel,
    this.loadMore = false,
    this.page = 1,
  });
  VisitorPassState copyWith({
    bool? isLoading,
    List<VisitorPassModel>? visitorPassModel,
    bool? loadMore,
    int? page,
  }) {
    return VisitorPassState(
        isLoading: isLoading ?? this.isLoading,
        page: page ?? this.page,
        loadMore: loadMore ?? this.loadMore,
        visitorPassModel: visitorPassModel ?? this.visitorPassModel
    );
  }
}
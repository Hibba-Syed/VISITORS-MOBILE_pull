part of 'check_ins_cubit.dart';

class CheckInsState {
  final bool isLoading;
  final bool loadMore;
  final int page;
  List<VisitorsCheckInsRecord>? checkInsRecord;
   CheckInsState({
    this.isLoading = false,
    this.loadMore = false,
    this.page = 1,
    this.checkInsRecord,
  });
  CheckInsState copyWith({
    bool? isLoading,
    bool? loadMore,
    int? page,
    List<VisitorsCheckInsRecord>? checkInsRecord,
  }) {
    return CheckInsState(
      isLoading: isLoading ?? this.isLoading,
      loadMore: loadMore ?? this.loadMore,
      page: page ?? this.page,
      checkInsRecord: checkInsRecord ?? this.checkInsRecord
    );
  }
}
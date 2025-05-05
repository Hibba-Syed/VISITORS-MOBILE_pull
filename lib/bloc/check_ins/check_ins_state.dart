part of 'check_ins_cubit.dart';

class CheckInsState {
  final bool isLoading;
  final bool isCheckOutAllLoading;
  final bool loadMore;
  final int page;
  List<CheckInsModel>? checkInsRecord;
   CheckInsState({
    this.isLoading = false,
    this.loadMore = false,
    this.page = 1,
    this.checkInsRecord,
     this.isCheckOutAllLoading = false,
  });
  CheckInsState copyWith({
    bool? isLoading,
     bool? isCheckOutAllLoading,
    bool? loadMore,
    int? page,
    List<CheckInsModel>? checkInsRecord,
  }) {
    return CheckInsState(
      isLoading: isLoading ?? this.isLoading,
        isCheckOutAllLoading: isCheckOutAllLoading ?? this.isCheckOutAllLoading,
      loadMore: loadMore ?? this.loadMore,
      page: page ?? this.page,
      checkInsRecord: checkInsRecord ?? this.checkInsRecord
    );
  }
}
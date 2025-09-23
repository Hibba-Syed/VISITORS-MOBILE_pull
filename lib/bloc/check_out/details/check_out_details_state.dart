part of 'check_out_details_cubit.dart';

class CheckOutDetailsState {
  final bool isLoading;
  List<LogModel>? checkOutLogs;
  CheckOutDetailsState({
    this.isLoading = false,
    this.checkOutLogs,
  });
  CheckOutDetailsState copyWith({
    bool? isLoading,
    bool? isCheckOutVisitor,
    List<LogModel>? checkOutLogs,
  }) {
    return CheckOutDetailsState(
      isLoading: isLoading ?? this.isLoading,
      checkOutLogs: checkOutLogs ?? this.checkOutLogs,
    );
  }
}

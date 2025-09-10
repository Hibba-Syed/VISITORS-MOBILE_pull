part of 'check_ins_details_cubit.dart';

class CheckInsDetailsState {
  final bool isLoading;
  final bool isCheckOutVisitor;
  List<LogModel>? checkInLogs;
  List<CheckOutModel>? checkOutVisitors;
  CheckInsDetailsState({
    this.isLoading = false,
    this.checkInLogs,
    this.isCheckOutVisitor = false,
    this.checkOutVisitors,
  });
  CheckInsDetailsState copyWith({
    bool? isLoading,
    bool? isCheckOutVisitor,
    List<LogModel>? checkInLogs,
    List<CheckOutModel>? checkOutVisitors,
  }) {
    return CheckInsDetailsState(
      isLoading: isLoading ?? this.isLoading,
      checkInLogs: checkInLogs ?? this.checkInLogs,
      isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
      checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
    );
  }
}

part of 'check_ins_details_cubit.dart';

class CheckInsDetailsState {
  final bool isLoading;
  final bool isCheckOutVisitor;
  List<CheckInLogs>? checkInLogModel;
  List<CheckOutVisitors>? checkOutVisitors;
  CheckInsDetailsState({
    this.isLoading = false,
    this.checkInLogModel,
    this.isCheckOutVisitor = false,
    this.checkOutVisitors,
  });
  CheckInsDetailsState copyWith({
    bool? isLoading,
    bool? isCheckOutVisitor,
    List<CheckInLogs>? checkInLogModel,
    List<CheckOutVisitors>? checkOutVisitors,
  }) {
    return CheckInsDetailsState(
      isLoading: isLoading ?? this.isLoading,
      checkInLogModel: checkInLogModel ?? this.checkInLogModel,
      isCheckOutVisitor: isCheckOutVisitor ?? this.isCheckOutVisitor,
      checkOutVisitors: checkOutVisitors ?? this.checkOutVisitors,
    );
  }
}

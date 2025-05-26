part of 'check_ins_details_cubit.dart';

class CheckInsDetailsState {
  final bool isLoading;
  List<CheckInLogRecord>? checkInLogModel;
  CheckInsDetailsState({
    this.isLoading = false,
  this.checkInLogModel,

  });
  CheckInsDetailsState copyWith({
    bool? isLoading,
    List<CheckInLogRecord>? checkInLogModel,

  }) {
    return CheckInsDetailsState(
        isLoading: isLoading ?? this.isLoading,
      checkInLogModel: checkInLogModel ?? this.checkInLogModel

    );
  }
}
part of 'check_ins_details_cubit.dart';

class CheckInsDetailsState {
  final bool isLoading;
  List<CheckInLogModel>? checkInLogModel;
  CheckInsDetailsState({
    this.isLoading = false,
  this.checkInLogModel,

  });
  CheckInsDetailsState copyWith({
    bool? isLoading,
    List<CheckInLogModel>? checkInLogModel,

  }) {
    return CheckInsDetailsState(
        isLoading: isLoading ?? this.isLoading,
      checkInLogModel: checkInLogModel ?? this.checkInLogModel

    );
  }
}
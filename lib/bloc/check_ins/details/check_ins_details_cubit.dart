import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/check_ins/check_in_log_model.dart';
import '../../../model/check_ins/check_in_log_response_model.dart';
import '../../../repo/check_ins/check_in_repo.dart';
import '../../../repo/check_ins/check_in_repo_impl.dart';

part 'check_ins_details_state.dart';

class CheckInsDetailsCubit extends Cubit<CheckInsDetailsState> {
  CheckInsDetailsCubit() : super(CheckInsDetailsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();

  Future<CheckInLogResponseModel?> getCheckInDetailsLog({required int? id}) async {
    emit(state.copyWith(isLoading: true));
    CheckInLogResponseModel? response =
    await _checkInRepo.getCheckInLogs(id: id).onError(
          (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    if (response != null && response.status == 'success') {
      emit(state.copyWith(isLoading: false));
       emit(state.copyWith(checkInLogModel: response.record,isLoading: false));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching check in log details');
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }
}

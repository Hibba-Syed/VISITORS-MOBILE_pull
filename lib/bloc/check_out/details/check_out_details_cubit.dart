import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/model/check_out/check_in_log_response_model.dart';
import 'package:visitors/repo/check_out/check_out_repo.dart';
import 'package:visitors/repo/check_out/check_out_repo_impl.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../model/log_model.dart';
import '../../../model/check_ins/check_in_log_response_model.dart';

part 'check_out_details_state.dart';

class CheckoutDetailsCubit extends Cubit<CheckOutDetailsState> {
  CheckoutDetailsCubit() : super(CheckOutDetailsState());
  final CheckOutRepo _checkOutRepo = CheckOutRepoImpl();

  Future<CheckInLogResponseModel?> getCheckOutDetailsLog(
      {required int? id}) async {
    emit(state.copyWith(isLoading: true));
    CheckOutLogResponseModel? response =
        await _checkOutRepo.getCheckOutDetailsLogs(id: id).onError(
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
      emit(state.copyWith(checkOutLogs: response.record, isLoading: false));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingCheckOutLogDetails'));
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }
}

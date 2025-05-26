import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/check_out/check_out_response_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/vendor/vendor_model.dart';
import '../../repo/check_outs/check_out_impl.dart';
import '../../repo/check_outs/check_out_repo.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutState());

  final CheckOutRepo _checkOutRepo = CheckOutImpl();

  Future<void> getCheckOut(
  {String? keyword}
      ) async {
    emit(state.copyWith(isCheckOutLoading: true));
    CheckOutResponseModel? response =
    await _checkOutRepo.getCheckOuts(
      keyword: keyword
    ).onError(
          (error, stackTrace) {
        emit(state.copyWith(isCheckOutLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isCheckOutLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(checkOutModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching check out');
    }
  }
}

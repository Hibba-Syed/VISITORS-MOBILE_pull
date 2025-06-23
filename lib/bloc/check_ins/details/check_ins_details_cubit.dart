
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';

import '../../../model/check_ins/check_in_log_model.dart';
import '../../../model/check_ins/check_in_log_response_model.dart';
import '../../../model/check_out/check_out_model.dart';
import '../../../model/check_outs/check_out_visitor_response_model.dart';
import '../../../repo/check_ins/check_in_repo.dart';
import '../../../repo/check_ins/check_in_repo_impl.dart';

part 'check_ins_details_state.dart';

class CheckInsDetailsCubit extends Cubit<CheckInsDetailsState> {
  CheckInsDetailsCubit() : super(CheckInsDetailsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();

  Future<CheckInLogResponseModel?> getCheckInDetailsLog({required int? id}) async {
    emit(state.copyWith(isLoading: true));
    CheckInLogResponseModel? response =
    await _checkInRepo.getCheckInDetailsLogs(id: id).onError(
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
       emit(state.copyWith(checkInLogs: response.record,isLoading: false));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching check in log details');
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }
  Future<bool> checkOutVisitors(
      BuildContext context, {
        required int? id,
        required Map<String, dynamic> data,
      }) async {
    emit(state.copyWith(isCheckOutVisitor: true));
    try {
      CheckOutVisitorResponseModel? response = await _checkInRepo
          .checkOutVisitors(data: data, id: id)
          .onError((error, stackTrace) {
        emit(state.copyWith(isCheckOutVisitor: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });
      emit(state.copyWith(isCheckOutVisitor: false));
      if (response != null && response.status == 'success') {
        //emit(state.copyWith(checkOutVisitors: (response.record==null)?state.checkOutVisitors:[response.record!, ...state.checkOutVisitors??[]]));
        final updated = response.record;
        if (updated != null) {
          final list = state.checkOutVisitors ?? [];

          final index = list.indexWhere((visitor) => visitor.id == updated.id);
          final updatedList = [...list];

          if (index != -1) {
            updatedList[index] = updated;
          } else {
            updatedList.insert(0, updated);
          }

          emit(state.copyWith(checkOutVisitors: updatedList));
        }
        if (context.mounted) {
          Navigator.pop(context);
          context.read<CheckInsCubit>().getCheckIns();
          Navigator.pop(context);
        }
        getCheckInDetailsLog(id: id);
        Fluttertoast.showToast(
            msg: (data['checkout'] != null)
                ? 'Checkout ${data['checkout'].toString()} visitors successfully'
                : ' Checkout successfully');
        return true;
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong while checking out visitor');
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isCheckOutVisitor: false));
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

// Future<bool> checkOutVisitors(
  //     BuildContext context, {
  //       required int? id,
  //       required Map<String, dynamic> data,
  //     }) async {
  //   emit(state.copyWith(isCheckOutVisitor: true));
  //   try {
  //     CheckOutVisitorResponseModel? response = await _checkInRepo
  //         .checkOutVisitors(
  //         data: data,
  //         id: id
  //     )
  //         .onError((error, stackTrace) {
  //       emit(state.copyWith(isCheckOutVisitor: false));
  //       // log( error.toString());
  //       Fluttertoast.showToast(
  //         msg: error.toString(),
  //       );
  //       return null;
  //     });
  //     emit(state.copyWith(isCheckOutVisitor: false));
  //     // log("CHECKOUT RESPONSES:::: ${response?.toJson()}");
  //     if (response != null && response.status == 'success') {
  //       emit(state.copyWith(checkOutVisitors: (response.record==null)?state.checkOutVisitors:[response.record!, ...state.checkOutVisitors??[]]));
  //       if (context.mounted) {
  //         Navigator.pop(context);
  //        getCheckInDetailsLog(id: id);
  //       }
  //       Fluttertoast.showToast(msg: (data['checkout']!=null)?'Checkout ${data['checkout'].toString()} visitors successfully' :' Checkout successfully');
  //       return true;
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: 'Something went wrong while checking out visitor');
  //       return false;
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(isCheckOutVisitor: false));
  //     Fluttertoast.showToast(msg: e.toString());
  //     // log('cubit call ${e.toString()}');
  //     return false;
  //   }
  // }
}

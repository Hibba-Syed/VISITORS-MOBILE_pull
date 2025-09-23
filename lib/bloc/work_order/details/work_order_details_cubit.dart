import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/model/work_order/work_order_details_model.dart';
import 'package:visitors/repo/work_order_rfp/work_order_repo_impl.dart';
import 'package:visitors/repo/work_order_rfp/work_order_repo.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../model/work_order/add_log_work_order_response_model.dart';
import '../../../model/work_order/work_order_details_response_model.dart';

part 'work_order_details_state.dart';

class WorkOrderDetailsCubit extends Cubit<WorkOrderDetailsState> {
  WorkOrderDetailsCubit() : super(WorkOrderDetailsState());

  final WorkOrderRFPRepo _workOrderRFPRepo = WorkOrderRFPRepoImpl();

  Future<WorkOrderDetailsResponseModel?> getWorkOrderDetails({required int? workOrderId}) async {
    emit(state.copyWith(isLoading: true));
    WorkOrderDetailsResponseModel? response =
    await _workOrderRFPRepo.getWorkOrderDetails(
        workOrderId: workOrderId
    ).onError(
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
      emit(state.copyWith(workOrderDetailsModel: response.record,isLoading: false));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingWorkOrderDetails'));
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }
  Future<bool> addWorkOrderLog(
      BuildContext context, {
        required Map<String, dynamic> data,
      }) async {
    emit(state.copyWith(isAddLogLoading: true));
    try {
      AddLogWorkOrderResponseModel? response = await _workOrderRFPRepo
          .addWorkOrderLog(data: data)
          .onError((error, stackTrace) {
        emit(state.copyWith(isAddLogLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });

      emit(state.copyWith(isAddLogLoading: false));

      if (response != null && response.status == 'success') {
        Fluttertoast.showToast(msg: AppUtils.languageTranslate('logAddedSuccessfully'));
        if(context.mounted){
          getWorkOrderDetails(workOrderId: context.read<WorkOrderDetailsCubit>().state.workOrderDetailsModel?.id);
        }
        return true;
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('somethingWentWrongWhileAddingLog'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isAddLogLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

}

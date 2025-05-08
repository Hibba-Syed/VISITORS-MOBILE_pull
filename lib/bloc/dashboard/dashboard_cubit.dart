import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/model/service/service_response_model.dart';

import '../../model/check_ins/check_ins_response_model.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/check_out/check_out_response_model.dart';
import '../../model/count/count_model.dart';
import '../../model/count/count_response_model.dart';
import '../../model/profile/profile_response_model.dart';
import '../../model/service/service_model.dart';
import '../../model/work_order/work_order_model.dart';
import '../../model/work_order/work_order_response_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/check_ins/check_in_repo_impl.dart';
import '../../repo/check_outs/check_out_impl.dart';
import '../../repo/check_outs/check_out_repo.dart';
import '../../repo/dashboard/dashboard_repo.dart';
import '../../repo/dashboard/dashboard_repo_impl.dart';
import '../../repo/profile/profile_repo.dart';
import '../../repo/profile/profile_repo_impl.dart';
import '../../repo/services/services_repo.dart';
import '../../repo/services/services_repo_impl.dart';
import '../../repo/work_order_rfp/work_order_impl.dart';
import '../../repo/work_order_rfp/work_order_repo.dart';
import '../../utils/preference_utils.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  final ProfileRepo _profileRepo = ProfileRepoImpl();
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  final DashboardRepo _dashboardRepo = DashboardRepoImpl();
  final ServiceRepo _serviceRepo = ServiceRepoImpl();
  final WorkOrderRFPRepo _workOrderRFPRepo = WorkOrderRFPImpl();


  Future<void> getProfile(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    ProfileResponseModel? profileResponse =
        await _profileRepo.getProfile().onError(
      (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isLoading: false));
    if (profileResponse != null) {
      spUtil.profileRecord = profileResponse.record;
      emit(state.copyWith(profileRecord: profileResponse.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> getDashboardCheckIns() async {
    emit(state.copyWith(isCheckInLoading: true));
    CheckInsResponseModel? response = await _checkInRepo.getCheckIns().onError(
      (error, stackTrace) {
        emit(state.copyWith(isCheckInLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isCheckInLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(checkInsModel: response.record));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitors check-ins');
    }
  }

  Future<void> getDashboardCount() async {
    emit(state.copyWith(isCountLoading: true));
    CountResponseModel? response =
        await _dashboardRepo.getDashboardCount().onError(
      (error, stackTrace) {
        emit(state.copyWith(isCountLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isCountLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(countModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching count');
    }
  }

  Future<void> getDashboardServices() async {
    emit(state.copyWith(isServicesLoading: true));
    ServiceResponseModel? response = await _serviceRepo.getServices().onError(
      (error, stackTrace) {
        emit(state.copyWith(isServicesLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isServicesLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(serviceModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching ');
    }
  }

  Future<void> getDashboardWorkOrder() async {
    emit(state.copyWith(isWorkOrderLoading: true));
    WorkOrderResponseModel? response =
        await _workOrderRFPRepo.getWorkOrder().onError(
      (error, stackTrace) {
        emit(state.copyWith(isWorkOrderLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isWorkOrderLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(workOrderModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching work order');
    }
  }

}

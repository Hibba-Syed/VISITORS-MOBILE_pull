
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/check_ins/check_ins_response_model.dart';
import '../../model/count/count_model.dart';
import '../../model/count/count_response_model.dart';
import '../../model/profile/profile_response_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/check_ins/check_in_repo_impl.dart';
import '../../repo/dashboard/dashboard_repo.dart';
import '../../repo/dashboard/dashboard_repo_impl.dart';
import '../../repo/profile/profile_repo.dart';
import '../../repo/profile/profile_repo_impl.dart';
import '../../utils/preference_utils.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  final ProfileRepo _profileRepo = ProfileRepoImpl();
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  final DashboardRepo _dashboardRepo = DashboardRepoImpl();

  Future<void> getProfile(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    ProfileResponseModel? profileResponse = await _profileRepo.getProfile().onError(
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
  Future<void> getCheckIns() async {
    emit(state.copyWith(isCheckInLoading: true));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns().onError(
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
    CountResponseModel? response = await _dashboardRepo
        .getDashboardCount().onError(
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
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching count');
    }
  }
}

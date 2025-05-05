
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/check_ins/check_ins_response_model.dart';
import '../../model/profile/profile_response_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/check_ins/check_in_repo_impl.dart';
import '../../repo/profile/profile_repo.dart';
import '../../repo/profile/profile_repo_impl.dart';
import '../../utils/preference_utils.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  final ProfileRepo _profileRepo = ProfileRepoImpl();
  final CheckInRepo _checkInRepo = CheckInRepoImpl();

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
    if (response != null) {
      emit(state.copyWith(checkInsRecord: response.record));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitors check-ins');
    }
  }
}

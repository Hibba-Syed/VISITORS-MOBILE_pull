import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/bloc/guest_check_in/guest_check_in_cubit.dart';
import 'package:visitors/model/service/service_response_model.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../model/check_ins/check_in_model.dart';
import '../../model/check_ins/check_ins_response_model.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/check_outs/check_out_visitor_response_model.dart';
import '../../model/count/count_model.dart';
import '../../model/count/count_response_model.dart';
import '../../model/profile/profile_response_model.dart';
import '../../model/service/service_model.dart';
import '../../model/visitor_passes/visitor_pass_model.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../model/visitor_passes/visitor_passes_count_response_model.dart';
import '../../model/work_order/work_order_model.dart';
import '../../model/work_order/work_order_response_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/check_ins/check_in_repo_impl.dart';
import '../../repo/dashboard/dashboard_repo.dart';
import '../../repo/dashboard/dashboard_repo_impl.dart';
import '../../repo/profile/profile_repo.dart';
import '../../repo/profile/profile_repo_impl.dart';
import '../../repo/services/services_repo.dart';
import '../../repo/services/services_repo_impl.dart';
import '../../repo/visitor_passes/visitor_pass_repo.dart';
import '../../repo/visitor_passes/visitor_pass_repo_impl.dart';
import '../../repo/work_order_rfp/work_order_repo_impl.dart';
import '../../repo/work_order_rfp/work_order_repo.dart';
import '../../utils/preference_utils.dart';
import '../../utils/routes/app_routes.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  final ProfileRepo _profileRepo = ProfileRepoImpl();
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  final DashboardRepo _dashboardRepo = DashboardRepoImpl();
  final ServiceRepo _serviceRepo = ServiceRepoImpl();
  final WorkOrderRFPRepo _workOrderRFPRepo = WorkOrderRFPRepoImpl();
  final VisitorPassRepo _visitorPassRepo = VisitorPassRepoImpl();

  Future<bool> getProfile() async {
    emit(state.copyWith(isLoading: true));

    ProfileResponseModel? profileResponse = await _profileRepo.getProfile();

    emit(state.copyWith(isLoading: false));

    if (profileResponse != null) {
      spUtil.profileRecord = profileResponse.record;
      emit(state.copyWith(profileRecord: profileResponse.record));
      return true;
    } else {
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrong'));
      return false;
    }
  }

  Future<void> getDashboardCheckIns({int? limit}) async {
    emit(state.copyWith(isCheckInLoading: true));
    CheckInsResponseModel? response =
        await _checkInRepo.getCheckIns(limit: limit).onError(
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
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingVisitorsCheckins'));
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
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingCount'));
    }
  }

  Future<void> getDashboardServices({int? limit}) async {
    emit(state.copyWith(isServicesLoading: true));
    ServiceResponseModel? response =
        await _serviceRepo.getServices(limit: limit).onError(
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
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingService'));
    }
  }

  Future<void> getDashboardWorkOrder({int? limit}) async {
    emit(state.copyWith(isWorkOrderLoading: true));
    WorkOrderResponseModel? response =
        await _workOrderRFPRepo.getWorkOrder(limit: limit).onError(
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
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingWorkOrderRfp'));
    }
  }

  Future<void> getVisitorPasses() async {
    emit(state.copyWith(isVisitorPassLoading: true, page: 1));
    VisitorPassResponseModel? response =
        await _visitorPassRepo.getVisitorPasses().onError(
      (error, stackTrace) {
        emit(state.copyWith(isVisitorPassLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isVisitorPassLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(visitorPasses: response.record));
    } else {
      Fluttertoast.showToast(
          msg:  AppUtils.languageTranslate('somethingWentWrongWhileFetchingVisitorPass'));
    }
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
        // log( error.toString());
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });
      emit(state.copyWith(isCheckOutVisitor: false));
      // log("CHECKOUT RESPONSES:::: ${response?.toJson()}");
      if (response != null && response.status == 'success') {
        final updated = response.record;
        if (updated != null) {
          final list = state.checkOutVisitors ?? [];

          final index = list.indexWhere((visitor) => visitor.id == updated.id);
          final updatedList = [...list];

          if (index != -1) {
            updatedList[index] = updated; // Replace existing item
          } else {
            updatedList.insert(0, updated); // Insert new item at top
          }

          emit(state.copyWith(checkOutVisitors: updatedList));
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
        getDashboardCheckIns();
        Fluttertoast.showToast(
            msg: (data['checkout'] != null)
                ? '${AppUtils.languageTranslate('checkout')} ${data['checkout'].toString()} ${AppUtils.languageTranslate('visitorsSuccessfully')}'
                : AppUtils.languageTranslate('checkoutSuccessfully'));
        return true;
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('somethingWentWrongWhileCheckingOutVisitor'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isCheckOutVisitor: false));
      Fluttertoast.showToast(msg: e.toString());
      // log('cubit call ${e.toString()}');
      return false;
    }
  }

  Future<void> getVisitorPassesCount() async {
    emit(state.copyWith(isVisitorPassesCountLoading: true));
    VisitorPassesCountResponseModel? response =
        await _visitorPassRepo.getVisitorPassesCount().onError(
      (error, stackTrace) {
        emit(state.copyWith(isVisitorPassesCountLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isCountLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(visitorPassesCount: response.record));
      // print('Visitor Pass Count cubit : ${response.record?.count}');
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingVisitorPassesCount'));
    }
  }


  Future<void> getData(
    BuildContext context,
    //{bool isNavigationAllow = true}
  ) async {
    final dashboardCubit = context.read<DashboardCubit>();

    bool profileSuccess = await dashboardCubit.getProfile();

    if (profileSuccess) {
      await Future.wait([
        dashboardCubit.getVisitorPassesCount(),
        dashboardCubit.getDashboardCheckIns(limit: 3),
        dashboardCubit.getDashboardCount(),
        dashboardCubit.getDashboardServices(limit: 3),
        dashboardCubit.getDashboardWorkOrder(limit: 3),
        context.read<GuestCheckInCubit>().getCountries(),
        context.read<GuestCheckInCubit>().getProfile(),
        context.read<GuestCheckInCubit>().getUnits(),
      ]);
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainDashboard,
          (route) => false,
        );
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.login,
          (route) => false,
        );
      }
    }
  }

  Future<void> refreshData(BuildContext context) async {
    final dashboardCubit = context.read<DashboardCubit>();
    await dashboardCubit.getDashboardCheckIns(limit: 3);
    await dashboardCubit.getDashboardCount();
    await dashboardCubit.getDashboardServices(limit: 3);
    await dashboardCubit.getDashboardWorkOrder(limit: 3);
    dashboardCubit.getVisitorPassesCount();
  }
}

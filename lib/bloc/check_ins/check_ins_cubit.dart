import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:visitors/bloc/dashboard/dashboard_cubit.dart';
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';
import 'package:visitors/model/check_outs/check_out_visitor_response_model.dart';
import 'package:visitors/repo/check_out/check_out_repo.dart';
import 'package:visitors/repo/check_out/check_out_repo_impl.dart';
import 'package:visitors/repo/visitor/visitor_repo.dart';
import 'package:visitors/repo/visitor/visitor_repo_impl.dart';
import '../../model/check_ins/check_in_model.dart';
import '../../model/check_out/check_out_all_model.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../repo/units/units_repo.dart';
import '../../repo/units/units_repo_impl.dart';
import '../../repo/vendors/vendors_repo.dart';
import '../../repo/vendors/vendors_repo_impl.dart';
import '../../utils/app_utils.dart';
import '../../utils/date_time.dart';

part 'check_ins_state.dart';

class CheckInsCubit extends Cubit<CheckInsState> {
  CheckInsCubit() : super(CheckInsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  final CheckOutRepo _checkOutRepo = CheckOutRepoImpl();
  final VendorsRepo _generalFilterRepo = VendorsRepoImpl();
  final UnitsRepo _unitsRepo = UnitsRepoImpl();
  final VisitorRepo _visitorRepo = VisitorRepoImpl();

  void onChangeSelectedVisitorType(TypeModel? type) {
    emit(state.copyWith(selectedVisitorType: type));
  }

  void onChangeSelectedServiceableId(int? serviceableId) {
    emit(state.copyWith(serviceableId: serviceableId));
  }

  void onChangeSelectedUnit(UnitModel? unit) {
    emit(state.copyWith(selectedUnit: unit));
    // print('unit::${state.selectedUnit?.toJson()}');
  }

  void onChangeSelectedVendors(VendorModel? vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }

  void onChangeDateRange(DateTimeRange? dateRange) {
    emit(state.copyWith(dateRange: dateRange));
  }

  void onChangeSelectedRange(String? range) {
    emit(state.copyWith(selectedRange: range));
  }

  void onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }

  void resetFilterData() {
    emit(CheckInsState(
      checkInModel: state.checkInModel,
      isCheckOutAllLoading: state.isCheckOutAllLoading,
      isLoading: state.isLoading,
      isUnitLoading: state.isUnitLoading,
      loadMore: state.loadMore,
      isVendorLoading: state.isVendorLoading,
      page: state.page,
      units: state.units,
      vendors: state.vendors,
    ));
  }

  Future<void> getCheckIns({String? keyword}) async {
    emit(state.copyWith(isLoading: true, page: 1));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
            keyword: state.searchKeyword,
            unitId: state.selectedUnit?.id,
            dateRange: DateTimeUtil.getFormatDateRange(state.dateRange),
            serviceableType: state.selectedVisitorType?.value,
            vendorId: state.selectedVendor?.id,
            serviceableId: state.serviceableId)
        .onError(
      (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(checkInModel: response.record));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingVisitorsCheckins'));
    }
  }

  Future<void> getMoreCheckIns({
    String? keyword,
  }) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
      page: state.page,
      keyword: keyword,
      unitId: state.selectedUnit?.id,
      serviceableType: state.selectedVisitorType?.value,
      vendorId: state.selectedVendor?.id,
      serviceableId: state.serviceableId,
      dateRange: DateTimeUtil.getFormatDateRange(state.dateRange),
    )
        .onError(
      (error, stackTrace) {
        emit(state.copyWith(loadMore: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(loadMore: false));
    if (response != null && response.status == 'success') {
      if (response.record?.isNotEmpty ?? false) {
        List<CheckInModel> checkIns = state.checkInModel ?? [];
        checkIns.addAll(response.record as Iterable<CheckInModel>);
        emit(state.copyWith(checkInModel: checkIns));
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('noMoreCheckins'));
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingCheckins'));
    }
  }

  Future<bool> checkOutAll(BuildContext context) async {
    emit(state.copyWith(isCheckOutAllLoading: true));

    CheckOutAll? response =
        await _checkOutRepo.checkOutAll().onError((error, stackTrace) {
      emit(state.copyWith(isCheckOutAllLoading: false));
      return null;
    });
    emit(state.copyWith(isCheckOutAllLoading: false));

    if (response != null && response.status == 'success') {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('checkOutAllVisitorsSuccessfully'));
      getCheckIns();
      if (context.mounted) {
        context.read<DashboardCubit>().getDashboardCheckIns();
        context.read<DashboardCubit>().getDashboardCount();
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongPleaseTryAgainLater'));
      return false;
    }
  }

  Future<bool> checkOutVisitors(
    BuildContext context, {
    required int? id,
    required Map<String, dynamic> data,
  }) async {
    emit(state.copyWith(isCheckOutVisitor: true));
    try {
      CheckOutVisitorResponseModel? response = await _visitorRepo
          .checkOutVisitors(data: data, id: id)
          .onError((error, stackTrace) {
        emit(state.copyWith(isCheckOutVisitor: false));
        log(error.toString());
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
          getCheckIns();
          Navigator.pop(context);
        }
        getCheckIns();
        Fluttertoast.showToast(
            msg: (data['checkout'] != null)
                ? '${AppUtils.languageTranslate('checkout')} ${data['checkout'].toString()} ${AppUtils.languageTranslate('checkout')} ${AppUtils.languageTranslate('visitorsSuccessfully')}'
                : '${AppUtils.languageTranslate('checkoutSuccessfully')} ');
        return true;
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'somethingWentWrongWhileCheckingOutVisitor'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isCheckOutVisitor: false));
      Fluttertoast.showToast(msg: e.toString());
      // log('cubit call ${e.toString()}');
      return false;
    }
  }

  Future<void> getUnits() async {
    emit(state.copyWith(isUnitLoading: true));
    UnitsResponseModel? response = await _unitsRepo.getUnits().onError(
      (error, stackTrace) {
        emit(state.copyWith(isUnitLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isUnitLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(units: response.record));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingUnits'));
    }
  }

  Future<void> getVendors() async {
    emit(state.copyWith(isVendorLoading: true));
    VendorsResponseModel? response =
        await _generalFilterRepo.getVendors().onError(
      (error, stackTrace) {
        emit(state.copyWith(isVendorLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isVendorLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(vendors: response.record));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingVendors'));
    }
  }
}

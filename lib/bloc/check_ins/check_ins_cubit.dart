import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';
import 'package:visitors/repo/filter/general_filter_impl.dart';

import '../../model/check_ins/check_out_all_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../repo/filter/general_filter_repo.dart';

part 'check_ins_state.dart';

class CheckInsCubit extends Cubit<CheckInsState> {
  CheckInsCubit() : super(CheckInsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  final GeneralFilterRepo _generalFilterRepo = GeneralFilterRepoImpl();

  Future<void> getCheckIns({
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
  }) async {
    emit(state.copyWith(isLoading: true, page: 1));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
            keyword: keyword,
            unitId: unitId,
            dateRange: dateRange,
            serviceableType: serviceableType,
            vendorId: vendorId)
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
    if (response != null) {
      emit(state.copyWith(checkInsRecord: response.record));
      print('response${response.record?.length}');
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitors check-ins');
    }
  }

  Future<void> getMoreCheckIns({
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
  }) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
            page: state.page,
            keyword: keyword,
            unitId: unitId,
            dateRange: dateRange,
            serviceableType: serviceableType,
            vendorId: vendorId)
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
    if (response != null) {
      if (response.record?.isNotEmpty ?? false) {
        List<CheckInModel> checkIns = state.checkInModel ?? [];
        checkIns.addAll(response.record as Iterable<CheckInModel>);
        emit(state.copyWith(checkInsRecord: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more check-ins');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching check-ins');
    }
  }

  Future<bool> checkOutAll(BuildContext context) async {
    emit(state.copyWith(isCheckOutAllLoading: true));

    CheckOutAllModel? response =
        await _checkInRepo.checkOutAll().onError((error, stackTrace) {
      emit(state.copyWith(isCheckOutAllLoading: false));
      Fluttertoast.showToast(msg: error.toString());
    });
    emit(state.copyWith(isCheckOutAllLoading: false));

    if (response != null) {
      Fluttertoast.showToast(msg: 'Check out all visitors successfully');
      getCheckIns();
      return true;
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong, please try again later');
      return false;
    }
  }

  Future<void> getUnits() async {
    emit(state.copyWith(isUnitLoading: true));
    UnitsResponseModel? response = await _generalFilterRepo.getUnits().onError(
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
      Fluttertoast.showToast(msg: 'Something went wrong while fetching units');
    }
  }

  Future<void> getVendors() async {
    emit(state.copyWith(isVendorLoading: true));
    VendorsResponseModel? response = await _generalFilterRepo.getVendors().onError(
      (error, stackTrace) {
        emit(state.copyWith(isVendorLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isVendorLoading: false));
    if (response != null) {
      emit(state.copyWith(vendorsModel: response));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching vendors');
    }
  }
}

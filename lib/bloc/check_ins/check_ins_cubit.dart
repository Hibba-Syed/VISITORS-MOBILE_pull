import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';
import 'package:visitors/repo/filter/general_filter_impl.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_filter_bottom_sheet.dart';

import '../../model/check_ins/check_in_model.dart';
import '../../model/check_out/check_out_all_model.dart';
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

  onChangeSelectedType(TypeModel? type) {
    emit(state.copyWith(selectedType: type));
  }

  onChangeSelectedServiceableId(int? serviceableId) {
    emit(state.copyWith(serviceableId: serviceableId));

  }
  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }

  onChangeSelectedVendors(VendorModel vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }

  onChangeDateRange(String? dateRange) {
    emit(state.copyWith(dateRang: dateRange));
  }

  onChangeRange(String? range) {
    emit(state.copyWith(selectedRang: range));
  }

  onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }
  clearFilterData() {
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
    )
    );
  }

  Future<void> getCheckIns({
    String? keyword,
  }) async {
    emit(state.copyWith(isLoading: true, page: 1));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
            keyword: state.searchKeyword,
            unitId: state.selectedUnit?.id,
            dateRange: state.dateRang,
            serviceableType: state.selectedType?.value,
            vendorId: state.selectedVendor?.id,
            serviceableId: state.serviceableId

    )
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
      print('response${response.record?.length}');
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitors check-ins');
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
            dateRange: state.dateRang,
            serviceableType: state.selectedType?.value,
            vendorId: state.selectedVendor?.id,
           serviceableId: state.serviceableId,

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
      ///
      return null;
    });
    emit(state.copyWith(isCheckOutAllLoading: false));

    if (response != null && response.status == 'success') {
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
          msg: 'Something went wrong while fetching vendors');
    }
  }
}

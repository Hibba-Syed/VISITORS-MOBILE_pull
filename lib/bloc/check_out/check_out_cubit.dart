import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/check_out/check_out_response_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../repo/check_outs/check_out_repo_impl.dart';
import '../../repo/check_outs/check_out_repo.dart';
import '../../repo/units/units_repo.dart';
import '../../repo/units/units_repo_impl.dart';
import '../../repo/vendors/vendors_repo.dart';
import '../../repo/vendors/vendors_repo_impl.dart';
import '../../utils/app_utils.dart';
import '../../utils/date_time.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutState());

  final CheckOutRepo _checkOutRepo = CheckOutRepoImpl();
  final VendorsRepo _generalFilterRepo = VendorsRepoImpl();
  final  UnitsRepo _unitsRepo = UnitsRepoImpl();


  // onChangeRange(String? range) {
  //   emit(state.copyWith(selectedRang: range));
  // }
  void onChangeSelectedRange(String? rangeLabel) {
    emit(state.copyWith(selectedRange: rangeLabel));
  }

  void onChangeDateRange(DateTimeRange? dateRange) {
    emit(state.copyWith(dateRang: dateRange));
  }

  void onChangeSelectedType(TypeModel? type) {
    emit(state.copyWith(selectedType: type));
  }
  void onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }
  void onChangeSelectedVendors(VendorModel vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }

  void onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }

  void resetFilterData() {
    emit(CheckOutState(
      checkOutVisitors: state.checkOutVisitors,
      isCheckOutAllLoading: state.isCheckOutAllLoading,
      isLoading: state.isLoading,
      isUnitLoading: state.isUnitLoading,
      loadMore: state.loadMore,
      isVendorLoading: state.isVendorLoading,
      page: state.page,
      units: state.units,
      vendors: state.vendors,
      isCheckOutLoading: state.isCheckOutLoading,

    )
    );
  }

  Future<void> getCheckOuts({ String? keyword}
      ) async {
    emit(state.copyWith(isCheckOutLoading: true,page: 1));
    CheckOutResponseModel? response =
    await _checkOutRepo.getCheckOuts(
       page: state.page,
        keyword: state.searchKeyword,
        unitId: state.selectedUnit?.id,
        dateRange: state.dateRang == null ? null : DateTimeUtil.getFormatDateRange(state.dateRang),
        serviceableType: state.selectedType?.value,
        vendorId: state.selectedVendor?.id,
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
      emit(state.copyWith(checkOutVisitors: response.record));
    } else {
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingCheckOut'));
    }
  }
  Future<void> getMoreCheckOut({
    String? keyword,
  }) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    CheckOutResponseModel? response = await _checkOutRepo
        .getCheckOuts(
      page: state.page,
      keyword: state.searchKeyword,
      unitId: state.selectedUnit?.id,
      dateRange:state.dateRang == null ? null : DateTimeUtil.getFormatDateRange(state.dateRang),
      serviceableType: state.selectedType?.value,
      vendorId: state.selectedVendor?.id,

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
        List<CheckOutVisitor> checkIns = state.checkOutVisitors ?? [];
        checkIns.addAll(response.record as Iterable<CheckOutVisitor>);
        emit(state.copyWith(checkOutVisitors: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more check-outs');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingCheckouts'));
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
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingUnits'));
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
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingVendors'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/check_out/check_out_model.dart';
import '../../model/check_out/check_out_response_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../repo/check_outs/check_out_impl.dart';
import '../../repo/check_outs/check_out_repo.dart';
import '../../repo/filter/general_filter_impl.dart';
import '../../repo/filter/general_filter_repo.dart';
import '../../utils/app_utils.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutState());

  final CheckOutRepo _checkOutRepo = CheckOutImpl();
  final GeneralFilterRepo _generalFilterRepo = GeneralFilterRepoImpl();


  // onChangeRange(String? range) {
  //   emit(state.copyWith(selectedRang: range));
  // }
  onChangeDateRange(String? dateRange) {
    emit(state.copyWith(dateRang: dateRange));
  }

  onChangeSelectedType(TypeModel? type) {
    emit(state.copyWith(selectedType: type));
  }
  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }
  onChangeSelectedVendors(VendorModel vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }

  onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }

  clearFilterData() {
    emit(CheckOutState(
      checkOutModel: state.checkOutModel,
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

  Future<void> getCheckOut(

      ) async {
    emit(state.copyWith(isCheckOutLoading: true));
    CheckOutResponseModel? response =
    await _checkOutRepo.getCheckOuts(
        keyword: state.searchKeyword,
        unitId: state.selectedUnit?.id,
        dateRange: state.dateRang,
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
      emit(state.copyWith(checkOutModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching check out');
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

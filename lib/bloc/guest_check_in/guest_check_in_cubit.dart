import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';
import 'package:visitors/repo/countries/countries_repo.dart';
import 'package:visitors/repo/countries/countries_repo_impl.dart';

import '../../model/country/countries_response_model.dart';
import '../../model/country/country_model.dart';
import '../../model/profile/profile_response_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/visitor_info/delete_visitor_response_model.dart';
import '../../model/visitor_info/number_info_model.dart';
import '../../model/visitor_info/visitor_phone_info_response_model.dart';
import '../../model/visitors_purpose_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/profile/profile_repo.dart';
import '../../repo/profile/profile_repo_impl.dart';
import '../../repo/units/units_repo.dart';
import '../../repo/units/units_repo_impl.dart';
import '../../utils/preference_utils.dart';

part 'guest_check_in_state.dart';

class GuestCheckInCubit extends Cubit<GuestCheckInState> {
  GuestCheckInCubit() : super(GuestCheckInState());

  final ProfileRepo _profileRepo = ProfileRepoImpl();
  final CountriesRepo _countriesRepo = CountriesRepoImpl();
  final  UnitsRepo _unitsRepo = UnitsRepoImpl();
  final CheckInRepo _checkInRepo = CheckInRepoImpl();

  onChangeSelectedCountry(Country? country) {
    emit(state.copyWith(selectedCountry: country ));
  }
  onChangeSelectedPurpose(VisitorsPurpose? purpose) {
    emit(state.copyWith(selectedPurpose: purpose ));
  }

  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }

  Future<void> getCountries() async {
    emit(state.copyWith(isCountriesLoading: true));
    CountriesResponseModel? response = await _countriesRepo.getCountries().onError(
          (error, stackTrace) {
        emit(state.copyWith(isCountriesLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isCountriesLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(countries: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching countries');
    }
  }

  Future<bool> getProfile() async {
    emit(state.copyWith(isProfileLoading: true));

    ProfileResponseModel? profileResponse = await _profileRepo.getProfile();

    emit(state.copyWith(isProfileLoading: false));

    if (profileResponse != null) {
      spUtil.profileRecord = profileResponse.record;
      emit(state.copyWith(profileRecord: profileResponse.record));
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
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
      Fluttertoast.showToast(msg: 'Something went wrong while fetching units');
    }
  }

  Future getNumberInfo({String? phoneNumber}) async {
    emit(state.copyWith(isNumberInfoLoading: true));
    VisitorPhoneInfoResponseModel? response = await _checkInRepo.getNumberInfo(
      phoneNumber: phoneNumber
    ).onError(
          (error, stackTrace) {
        emit(state.copyWith(isNumberInfoLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isNumberInfoLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(numberInfo: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching number Info');
    }
  }

  Future<bool> deleteVisitor(BuildContext context,
      {required int? id,
        required String? phoneNumber,
        int? remainingVisitors}) async {
    print("remaining Visitors::: $remainingVisitors");
    emit(state.copyWith(isDeleteVisitorLoading: true));
    DeleteVisitorResponseModel? response =
    await _checkInRepo.deleteVisitor(id: id).onError((error, stackTrace) {
      emit(state.copyWith(isDeleteVisitorLoading: false));
      return null;
    });
    emit(state.copyWith(isDeleteVisitorLoading: false));
    if (response != null && response.status == 'success') {
      Fluttertoast.showToast(msg: 'visitor deleted successfully');
      if ((phoneNumber?.isNotEmpty ?? false) &&
          (remainingVisitors ?? 0) > 0) {
        // If there are remaining visitors, fetch the number info again
        // to update the UI with the latest visitor count.
        getNumberInfo(phoneNumber: phoneNumber);
      }
      if (remainingVisitors == 0) {
        Navigator.pop(context);
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong, please try again later');
      return false;
    }
  }
}

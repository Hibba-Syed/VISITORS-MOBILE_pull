import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../model/check_ins/countries_model.dart';
import '../../model/check_ins/countries_response_model.dart';
import '../../repo/check_ins/check_in_repo.dart';
import '../../repo/check_ins/check_in_repo_impl.dart';

part 'guest_check_in_state.dart';

class GuestCheckInCubit extends Cubit<GuestCheckInState> {
  GuestCheckInCubit() : super(GuestCheckInState());

  final CheckInRepo _checkInRepo = CheckInRepoImpl();

  onChangeSelectedCountry(Countries? country) {
    emit(state.copyWith(selectedCountries: country ));
  }

  Future<void> getCountries() async {
    emit(state.copyWith(isLoading: true));
    CountriesResponseModel? response = await _checkInRepo.getCountries().onError(
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
      emit(state.copyWith(countries: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching countries');
    }
  }
}

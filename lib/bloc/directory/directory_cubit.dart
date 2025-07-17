
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../repo/units/units_repo.dart';
import '../../repo/units/units_repo_impl.dart';

part 'directory_state.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit() : super(DirectoryState());

  final  UnitsRepo _unitsRepo = UnitsRepoImpl();

  void onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }
  void setOwnerData(PrimaryOwner? owner) {
    emit(state.copyWith(primaryOwner: owner));
  }
  void setResidentData(Resident? resident) {
    emit(state.copyWith(resident: resident));
  }
  void resetOwnerAndResident() {
    emit(DirectoryState(
      isLoading: state.isLoading,
      units: state.units,
    )
    );
  }
  Future<void> getUnits() async {
    emit(state.copyWith(isLoading: true));
    UnitsResponseModel? response = await _unitsRepo.getUnits().onError(
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
      emit(state.copyWith(units: response.record));
    } else {
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingUnits'));
    }
  }
  void resetUnitData() {
    emit(state.copyWith());
  }

}

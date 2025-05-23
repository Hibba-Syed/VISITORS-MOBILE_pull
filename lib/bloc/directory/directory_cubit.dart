
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../repo/filter/general_filter_impl.dart';
import '../../repo/filter/general_filter_repo.dart';

part 'directory_state.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit() : super(DirectoryState());

  final GeneralFilterRepo _generalFilterRepo = GeneralFilterRepoImpl();

  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }
  void setOwnerData(PrimaryOwner? owner) {
    emit(state.copyWith(primaryOwner: owner));
  }
  void setResidentData(Resident? resident) {
    emit(state.copyWith(resident: resident));
  }
  resetOwnerAndResident() {
    emit(DirectoryState(
      isLoading: state.isLoading,
      units: state.units,
    )
    );
  }
  Future<void> getUnits() async {
    emit(state.copyWith(isLoading: true));
    UnitsResponseModel? response = await _generalFilterRepo.getUnits().onError(
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
      Fluttertoast.showToast(msg: 'Something went wrong while fetching units');
    }
  }

}

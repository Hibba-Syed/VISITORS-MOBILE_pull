import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:meta/meta.dart';
import 'package:visitors/model/check_ins/visitors_check_ins_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';

part 'check_ins_state.dart';

class CheckInsCubit extends Cubit<CheckInsState> {
  CheckInsCubit() : super( CheckInsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  Future<void> getCheckIns() async {
    emit(state.copyWith(isLoading: true,page: 1));
    VisitorCheckInsModel? response = await _checkInRepo
        .getCheckIns(
    ).onError(
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
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitors check-ins');
    }
  }
}

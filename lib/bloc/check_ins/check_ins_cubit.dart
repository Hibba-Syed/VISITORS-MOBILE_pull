import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';

part 'check_ins_state.dart';

class CheckInsCubit extends Cubit<CheckInsState> {
  CheckInsCubit() : super( CheckInsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  Future<void> getCheckIns() async {
    emit(state.copyWith(isLoading: true,page: 1));
    CheckInsResponseModel? response = await _checkInRepo
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

  Future<void> getMoreCheckIns() async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
      page: state.page,
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
    if (response != null) {
      if (response.record?.isNotEmpty ?? false) {
        List<CheckInsRecord> checkIns = state.checkInsRecord ?? [];
        checkIns.addAll(response.record as Iterable<CheckInsRecord>);
        emit(state.copyWith(checkInsRecord: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more check-ins');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching check-ins');
    }
  }
}

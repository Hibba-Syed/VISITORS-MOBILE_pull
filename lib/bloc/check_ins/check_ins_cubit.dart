import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/repo/check_ins/check_in_repo.dart';
import 'package:visitors/repo/check_ins/check_in_repo_impl.dart';

part 'check_ins_state.dart';

class CheckInsCubit extends Cubit<CheckInsState> {
  CheckInsCubit() : super( CheckInsState());
  final CheckInRepo _checkInRepo = CheckInRepoImpl();
  Future<void> getCheckIns(
      {String? keyword}
      ) async {
    emit(state.copyWith(isLoading: true,page: 1));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
      keyword: keyword,
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

  Future<void> getMoreCheckIns(
      {required String keyword}
      ) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    CheckInsResponseModel? response = await _checkInRepo
        .getCheckIns(
      page: state.page,
      keyword:keyword
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
        List<CheckInsModel> checkIns = state.checkInsRecord ?? [];
        checkIns.addAll(response.record as Iterable<CheckInsModel>);
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
  Future<void> checkOutAll(
      BuildContext context) async {
    emit(state.copyWith(isCheckOutAllLoading: true));
    await _checkInRepo.checkOutAll(

    ).onError(
          (error, stackTrace) {
        emit(state.copyWith(isCheckOutAllLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    ).then(
          (response) {
        emit(state.copyWith(isCheckOutAllLoading: false));
        if (response != null) {
          Fluttertoast.showToast(msg: 'Check out all successfully');
          if (context.mounted) {
            Navigator.pop(context);
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong, please try again later');
        }
      },
    );
  }

}

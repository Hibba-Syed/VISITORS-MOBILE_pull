import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../model/visitor_passes/visitor_pass_model.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../repo/visitor_passes/visitor_pass_repo.dart';
import '../../repo/visitor_passes/visitor_pass_repo_impl.dart';

part 'visitor_pass_state.dart';

class VisitorPassCubit extends Cubit<VisitorPassState> {
  VisitorPassCubit() : super(VisitorPassState());
  final VisitorPassRepo _visitorPassRepo = VisitorPassRepoImpl();

  Future<void> getVisitorPass({
    String? keyword,
  }) async {
    emit(state.copyWith(isLoading: true, page: 1));
    VisitorPassResponseModel? response = await _visitorPassRepo
        .getVisitorPass(
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
    if (response != null && response.status == 'success') {
      emit(state.copyWith(visitorPassModel: response.record));
      //print('response${response.record?.length}');
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitor pass');
    }
  }

}

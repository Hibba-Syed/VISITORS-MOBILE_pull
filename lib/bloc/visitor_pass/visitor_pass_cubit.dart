import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/visitor_passes/visitor_pass_model.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../repo/filter/general_filter_impl.dart';
import '../../repo/filter/general_filter_repo.dart';
import '../../repo/visitor_passes/visitor_pass_repo.dart';
import '../../repo/visitor_passes/visitor_pass_repo_impl.dart';

part 'visitor_pass_state.dart';

class VisitorPassCubit extends Cubit<VisitorPassState> {
  VisitorPassCubit() : super(VisitorPassState());
  final VisitorPassRepo _visitorPassRepo = VisitorPassRepoImpl();
  final GeneralFilterRepo _generalFilterRepo = GeneralFilterRepoImpl();

  onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }

  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }

  clearFilterData() {
    emit(VisitorPassState(
      isLoading: state.isLoading,
      isUnitLoading: state.isUnitLoading,
      loadMore: state.loadMore,
      page: state.page,
      units: state.units,
      visitorPassModel: state.visitorPassModel,
    ));
  }

  Future<void> getVisitorPass() async {
    emit(state.copyWith(isLoading: true, page: 1));
    VisitorPassResponseModel? response = await _visitorPassRepo
        .getVisitorPass(
      keyword: state.searchKeyword,
      unitId: state.selectedUnit?.id,
    )
        .onError(
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

  Future<void> getMoreVisitorPass() async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    VisitorPassResponseModel? response = await _visitorPassRepo
        .getVisitorPass(
            page: state.page,
            unitId: state.selectedUnit?.id,
            keyword: state.searchKeyword)
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
        List<VisitorPassModel> checkIns = state.visitorPassModel ?? [];
        checkIns.addAll(response.record as Iterable<VisitorPassModel>);
        emit(state.copyWith(visitorPassModel: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more visitor pass ');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitor pass ');
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
}

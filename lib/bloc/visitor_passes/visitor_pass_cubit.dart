import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/repo/units/units_repo.dart';
import 'package:visitors/repo/units/units_repo_impl.dart';


import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../model/visitor_passes/visitor_pass_model.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../repo/visitor_passes/visitor_pass_repo.dart';
import '../../repo/visitor_passes/visitor_pass_repo_impl.dart';

part 'visitor_pass_state.dart';

class VisitorPassCubit extends Cubit<VisitorPassState> {
  VisitorPassCubit() : super(VisitorPassState());
  final VisitorPassRepo _visitorPassRepo = VisitorPassRepoImpl();
  final UnitsRepo _unitsRepo = UnitsRepoImpl();

  onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }

  onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }

  resetFilterData() {
    emit(VisitorPassState(
      isLoading: state.isLoading,
      isUnitLoading: state.isUnitLoading,
      loadMore: state.loadMore,
      page: state.page,
      units: state.units,
      visitorPasses: state.visitorPasses,
    ));
  }

  Future<void> getVisitorPasses() async {
    emit(state.copyWith(isLoading: true, page: 1));
    VisitorPassResponseModel? response = await _visitorPassRepo
        .getVisitorPasses(
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
      emit(state.copyWith(visitorPasses: response.record));
      //print('response${response.record?.length}');
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching visitor pass');
    }
  }

  Future<void> getMoreVisitorPasses() async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    VisitorPassResponseModel? response = await _visitorPassRepo
        .getVisitorPasses(
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
        List<VisitorPasses> checkIns = state.visitorPasses ?? [];
        checkIns.addAll(response.record as Iterable<VisitorPasses>);
        emit(state.copyWith(visitorPasses: checkIns));
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
}

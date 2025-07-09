import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/service/service_model.dart';
import '../../model/service/service_response_model.dart';
import '../../model/unit/unit_model.dart';
import '../../model/unit/units_response_model.dart';
import '../../repo/services/services_repo.dart';
import '../../repo/services/services_repo_impl.dart';
import '../../repo/units/units_repo.dart';
import '../../repo/units/units_repo_impl.dart';
import '../../utils/app_utils.dart';
part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceState());
  final ServiceRepo _serviceRepo = ServiceRepoImpl();
  final  UnitsRepo _unitsRepo = UnitsRepoImpl();

  void onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }
  void onChangeSelectedType(TypeModel? type) {
    emit(state.copyWith(selectedType: type));
  }

  void onChangeSelectedUnit(UnitModel unit) {
    emit(state.copyWith(selectedUnit: unit));
  }

  void resetFilterData() {
    emit(ServiceState(
      serviceModel: state.serviceModel,
      isServicesDetailsLoading: state.isServicesDetailsLoading,
      isLoading: state.isLoading,
      isUnitLoading: state.isUnitLoading,
      loadMore: state.loadMore,
      page: state.page,
      units: state.units,
    )
    );
  }

  Future<void> getServices({String? keyword}) async {
    emit(state.copyWith(isLoading: true));

    ServiceResponseModel? response =
        await _serviceRepo.getServices(
          page: state.page,
          keyword: state.searchKeyword,
          unitId: state.selectedUnit?.id,
          serviceType: state.selectCheckInTypeList?.value,
          type: state.selectedType?.value
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
      emit(state.copyWith(serviceModel: response.record));
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingService'));
    }
  }
  Future<void> getMoreServices({
    String? keyword,
  }) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    ServiceResponseModel? response = await _serviceRepo
        .getServices(
      page: state.page,
      keyword: state.searchKeyword,
      unitId: state.selectedUnit?.id,
      serviceType: state.selectedType?.value,

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
    if (response != null && response.status == 'success') {
      if (response.record?.isNotEmpty ?? false) {
        List<ServiceModel> checkIns = state.serviceModel ?? [];
        checkIns.addAll(response.record as Iterable<ServiceModel>);
        emit(state.copyWith(serviceModel: checkIns));
      } else {
        Fluttertoast.showToast(msg: AppUtils.languageTranslate('noMoreService'));
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingService'));
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
      Fluttertoast.showToast(msg: AppUtils.languageTranslate('somethingWentWrongWhileFetchingUnits'));
    }
  }
}

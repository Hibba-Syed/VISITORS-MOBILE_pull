
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../model/work_order/work_order_model.dart';
import '../../model/work_order/work_order_response_model.dart';
import '../../repo/vendors/vendors_repo.dart';
import '../../repo/vendors/vendors_repo_impl.dart';
import '../../repo/work_order_rfp/work_order_repo_impl.dart';
import '../../repo/work_order_rfp/work_order_repo.dart';
import '../../utils/app_utils.dart';

part 'work_order_state.dart';

class WorkOrderCubit extends Cubit<WorkOrderState> {
  WorkOrderCubit() : super(WorkOrderState());
  final WorkOrderRFPRepo _workOrderRFPRepo  = WorkOrderRFPRepoImpl();
  final VendorsRepo _generalFilterRepo = VendorsRepoImpl();

  void onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }
  void onChangeSelectedVendors(VendorModel vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }

   void onChangeSelectedType(TypeModel? type) {
    emit(state.copyWith(
      selectedType: type,
    ));
  }
  void resetFilterData() {
    emit(WorkOrderState(
      workOrderModel: state.workOrderModel,
      isLoading: state.isLoading,
      loadMore: state.loadMore,
      isVendorLoading: state.isVendorLoading,
      page: state.page,
      vendors: state.vendors,
    )
    );
  }

  Future<void> getWorkOrder(
      ) async {
    emit(state.copyWith(isLoading: true, page: 1));
    WorkOrderResponseModel? response = await _workOrderRFPRepo.getWorkOrder(
      keyword: state.searchKeyword,
      isAwarded: state.selectedType?.value,
      vendorId: state.selectedVendor?.id,
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
      emit(state.copyWith(workOrderModel: response.record));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching work order, rfp');
    }
  }
  Future<void> getVendors() async {
    emit(state.copyWith(isVendorLoading: true));
    VendorsResponseModel? response =
    await _generalFilterRepo.getVendors().onError(
          (error, stackTrace) {
        emit(state.copyWith(isVendorLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isVendorLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(vendors: response.record));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching vendors');
    }
  }
  Future<void> getMoreWorkOrder() async {
    int page = state.page+ 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    WorkOrderResponseModel? response = await _workOrderRFPRepo
        .getWorkOrder(
      keyword: state.searchKeyword,
      isAwarded: state.selectedType?.value,
      vendorId: state.selectedVendor?.id,

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
        List<WorkOrderModel> checkIns = state.workOrderModel ?? [];
        checkIns.addAll(response.record as Iterable<WorkOrderModel>);
        emit(state.copyWith(workOrderModel: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more work order');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching work order');
    }
  }
}

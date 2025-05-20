
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/vendor/vendor_model.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../model/work_order/work_order_model.dart';
import '../../model/work_order/work_order_response_model.dart';
import '../../repo/filter/general_filter_impl.dart';
import '../../repo/filter/general_filter_repo.dart';
import '../../repo/work_order_rfp/work_order_impl.dart';
import '../../repo/work_order_rfp/work_order_repo.dart';

part 'work_order_state.dart';

class WorkOrderCubit extends Cubit<WorkOrderState> {
  WorkOrderCubit() : super(WorkOrderState());
  final WorkOrderRFPRepo _workOrderRFPRepo  = WorkOrderRFPImpl();
  final GeneralFilterRepo _generalFilterRepo = GeneralFilterRepoImpl();

  onChangeSearchKeyWord(String? keyword) {
    emit(state.copyWith(searchKeyword: keyword));
  }
  onChangeSelectedVendors(VendorModel vendor) {
    emit(state.copyWith(selectedVendor: vendor));
  }
  onChangeSelectedType(String? type) {
    emit(state.copyWith(selectedType: type));
  }

  clearFilterData() {
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
   // String type = (state.isAwarded == 1) ? 'Work Order' : 'RFP';
    WorkOrderResponseModel? response = await _workOrderRFPRepo.getWorkOrder(
      keyword: state.searchKeyword,
      isAwarded: state.isAwarded,
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
}

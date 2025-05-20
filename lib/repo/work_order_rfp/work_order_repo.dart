import '../../model/work_order/work_order_response_model.dart';

abstract class WorkOrderRFPRepo {
  Future<WorkOrderResponseModel?> getWorkOrder({
    int? page,
    int? limit,
    String? keyword,
    int? isAwarded,
    int? vendorId,
  });
}

import 'package:visitors/model/work_order/work_order_details_response_model.dart';

import '../../model/work_order/add_log_work_order_response_model.dart';
import '../../model/work_order/work_order_response_model.dart';

abstract class WorkOrderRFPRepo {
  Future<WorkOrderResponseModel?> getWorkOrder({
    int? page,
    int? limit,
    String? keyword,
    String? isAwarded,
    int? vendorId,
  });
  Future<WorkOrderDetailsResponseModel?> getWorkOrderDetails( { required int? workOrderId});
  Future<AddLogWorkOrderResponseModel?> addWorkOrderLog(
      {required Map<String, dynamic> data,
  });


}

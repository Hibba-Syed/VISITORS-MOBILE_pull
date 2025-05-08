import 'package:visitors/model/work_order/work_order_response_model.dart';
import 'package:visitors/repo/work_order_rfp/work_order_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../resource/constants/api_url.dart';

class WorkOrderRFPImpl implements WorkOrderRFPRepo{
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<WorkOrderResponseModel?> getWorkOrder({
    int? page,
    int? limit,
    String? keyword,
    int? vendorId,
    String? isAwarded,
  }) async {
    try {
      String url =
          '${ApiUrl.workOrder}?page=${page ?? 1}&limit=${limit ??
          10}&keyword=${keyword ?? ''}&is_awarded=${isAwarded ?? ''}&vendor_id=${vendorId ?? ''}';
      print('workOrder^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return WorkOrderResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
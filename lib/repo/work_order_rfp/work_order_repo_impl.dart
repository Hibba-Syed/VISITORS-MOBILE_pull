import 'package:visitors/model/work_order/work_order_details_response_model.dart';
import 'package:visitors/model/work_order/work_order_response_model.dart';
import 'package:visitors/repo/work_order_rfp/work_order_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/work_order/add_log_work_order_response_model.dart';
import '../../resource/constants/api_url.dart';
import '../encrption/encryption_helper.dart';

class WorkOrderRFPRepoImpl implements WorkOrderRFPRepo{
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
       // print('workOrder^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return WorkOrderResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<WorkOrderDetailsResponseModel?> getWorkOrderDetails({required int? workOrderId}) async {
    try {
     // final filter = {"vendors":{"include":[{"relation":"new_vendor","select":["id","company_name","contact_number","contact_email"]},{"relation":"category","select":["name"]},{"relation":"assets","select":["name"]},{"relation":"primary_contact","select":["jp_job_id","name","email","contact_number","is_primary"]}]}};
      final filter = {"filter":{"include":[{"relation":"new_vendor","select":["id","company_name","contact_number","contact_email"]},{"relation":"category","select":["name"]},{"relation":"assets","select":["name"]},{"relation":"primary_contact","select":["jp_job_id","name","email","contact_number","is_primary"]}]}};
      String url = '${ApiUrl.workOrderDetails}/$workOrderId?xyz=${Uri.encodeComponent(EncryptionHelper.encryptPayload(filter))}';
      dynamic response = await _apiService.getAuthGetApiResponse((url));
      return WorkOrderDetailsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<AddLogWorkOrderResponseModel?> addWorkOrderLog({required Map<String, dynamic> data}) async {
    try {
      dynamic response =
      await _apiService.getPostApiResponse(ApiUrl.addWorkOrderLog, data);
      return AddLogWorkOrderResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
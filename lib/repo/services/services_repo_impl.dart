
import 'package:http/http.dart' as http;
import 'package:visitors/model/service/service_details_response_model.dart';
import 'package:visitors/model/service/service_response_model.dart';
import 'package:visitors/repo/services/services_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/service/add_service_log_response_model.dart';
import '../../model/service/move_out_service_clear_payment_response_model.dart';
import '../../model/service/vIsitors_service_complete_response_model.dart';
import '../../resource/constants/api_url.dart';
import '../encrption/encryption_helper.dart';

class ServiceRepoImpl implements ServiceRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? serviceType,
    String? type,
  }) async {
    try {
      String url =
          '${ApiUrl.service}?page=${page ?? 1}&limit=${limit ??
          10}&keyword=${keyword ?? ''}&serviceable_type=${serviceType ?? ''}&unit_id=${unitId ?? ''}&type=${type ?? ''}';
      print('services^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return ServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<ServiceDetailsResponseModel?> getServiceDetails({int? serviceId}) async {
    print('service details URL: $serviceId');
    try {
      final filter = {"filter":{"where":{"and":[{"field":"id","value":serviceId}]},"include":[{"relation":"application"},{"relation":"status_history","include":[{"relation":"user","select":["id","first_name","last_name"]}]},{"relation":"unit","select":["id"]}, {"relation": "documents"}]}};
      print(filter);
      String url = '${ApiUrl.serviceDetails}?xyz=${Uri.encodeComponent(EncryptionHelper.encryptPayload(filter))}';

       print('service details URL: ${Uri.parse(url)}');
      dynamic response = await _apiService.getAuthGetApiResponse((url));
      return ServiceDetailsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<AddServiceLogResponseModel?> addServiceLog({required Map<String, dynamic> data}) async {
    try {
      print('add log: ${ApiUrl.addServiceLog}');
      dynamic response =
      await _apiService.getPostApiResponse(ApiUrl.addServiceLog, data);
      return AddServiceLogResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VisitorsServiceCompleteResponseModel?> completeService({required Map<String, dynamic> data}) async {
    try {
     // print('service complete: ${ApiUrl.serviceComplete}');
      dynamic response =
      await _apiService.getPostApiResponse(ApiUrl.serviceComplete, data);
      // print('Raw API Response: $response');
      return VisitorsServiceCompleteResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<MoveOutServiceClearPaymentResponseModel?> clearPayment({
    required int? id,
    required Map<String, dynamic> data,
     required List<http.MultipartFile> files,
  }) async {
    try {
      String url = '${ApiUrl.clearPayment}/$id';
      // print('clearPayment^^ $url');
      dynamic response = await _apiService.getAuthPostApiMultipartResponse(
        url,
        data,
         files,
      );
      return MoveOutServiceClearPaymentResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}


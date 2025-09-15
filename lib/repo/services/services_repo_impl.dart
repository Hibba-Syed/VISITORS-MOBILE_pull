import 'package:visitors/model/service/service_details_response_model.dart';
import 'package:visitors/model/service/service_response_model.dart';
import 'package:visitors/repo/services/services_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/service/add_service_log_response_model.dart';
import '../../model/service/visitors_service_complete_response_model.dart';
import '../../resource/constants/api_url.dart';
import '../../helper/encrption/encryption_helper.dart';

class ServiceRepoImpl implements ServiceRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? type,
  }) async {
    try {
      String url =
          '${ApiUrl.service}?page=${page ?? 1}&limit=${limit ?? 10}&keyword=${keyword ?? ''}&unit_id=${unitId ?? ''}&type=${type ?? ''}';
      // print('services^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return ServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ServiceDetailsResponseModel?> getServiceDetails(
      {required int? serviceId, required String? applicationType}) async {
    try {
      // final filter = {"vendors":{"where":{"and":[{"field":"id","value":serviceId}]},"include":[{"relation":"application"},{"relation":"status_history","include":[{"relation":"user","select":["id","first_name","last_name"]}]},{"relation":"unit","select":["id"]}, {"relation": "documents"}]}};
      print('type::::$applicationType');
      final filter = {
        "filter": {
          "where": {
            "and": [
              {"field": "id", "value": serviceId}
            ]
          },
          "include": [
            {
              "relation": "application",
              if (applicationType == 'CCS')
                "include": [
                  {
                    "relation": "fields",
                    "include": [
                      {"relation": "values"}
                    ]
                  }
                ]
            },
            {
              "relation": "status_history",
              "include": [
                {
                  "relation": "user",
                  "select": ["id", "first_name", "last_name"]
                }
              ]
            },
            {
              "relation": "unit",
              "select": ["id"]
            },
            {"relation": "evidence"},
            {"relation": "documents"}
          ]
        }
      };
      String url =
          '${ApiUrl.serviceDetails}?xyz=${Uri.encodeComponent(EncryptionHelper.encryptPayload(filter))}';
      dynamic response = await _apiService.getAuthGetApiResponse((url));
      return ServiceDetailsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddServiceLogResponseModel?> addServiceLog(
      {required Map<String, dynamic> data}) async {
    try {
      // print('add log: ${ApiUrl.addServiceLog}');
      dynamic response =
          await _apiService.getPostApiResponse(ApiUrl.addServiceLog, data);
      return AddServiceLogResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VisitorsServiceCompleteResponseModel?> completeService({
    required Map<String, dynamic> data,
  }) async {
    try {
      // print('service complete: ${ApiUrl.serviceComplete}'
      //'/$serviceId'
      // );
      dynamic response =
          await _apiService.getPostApiResponse(ApiUrl.serviceComplete, data);
      // print('Raw API Response: $response');
      return VisitorsServiceCompleteResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VisitorsServiceCompleteResponseModel?> completeAccessDeviceService(
      {required Map<String, dynamic> data, required int? serviceId}) async {
    try {
      // print('completeAccessDeviceService ${ApiUrl.serviceAccessDeviceComplete}/$serviceId');
      dynamic response =
          await _apiService.getPostApiResponse(ApiUrl.serviceComplete, data);
      // print('completeAccessDeviceService $response');
      return VisitorsServiceCompleteResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

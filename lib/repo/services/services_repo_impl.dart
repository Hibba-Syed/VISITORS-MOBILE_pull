import 'package:visitors/model/service/service_response_model.dart';
import 'package:visitors/repo/services/services_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../resource/constants/api_url.dart';

class ServiceRepoImpl implements ServiceRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? serviceType,
  }) async {
    try {
      String url =
          '${ApiUrl.service}?page=${page ?? 1}&limit=${limit ??
          10}&keyword=${keyword ?? ''}&serviceable_type=${serviceType ?? ''}&unit_id=${unitId ?? ''}';
      print('services^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return ServiceResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
import 'package:visitors/model/unit/units_response_model.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../resource/constants/api_url.dart';
import 'general_filter_repo.dart';

class GeneralFilterRepoImpl implements GeneralFilterRepo{
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<UnitsResponseModel?> getUnits()async {
    try {
      String url = ApiUrl.units;
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return UnitsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<VendorsResponseModel?> getVendors()async {
    try {
      String url = ApiUrl.vendors;
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return VendorsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
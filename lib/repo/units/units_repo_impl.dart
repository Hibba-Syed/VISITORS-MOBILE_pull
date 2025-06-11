import 'package:visitors/repo/units/units_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/unit/units_response_model.dart';
import '../../resource/constants/api_url.dart';

class UnitsRepoImpl implements UnitsRepo {
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
}
import 'package:visitors/model/check_ins/visitors_check_ins_response_model.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../resource/constants/api_url.dart';
import 'check_in_repo.dart';

class CheckInRepoImpl implements CheckInRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<VisitorCheckInsResponseModel?> getCheckIns({int? page, int? limit})async {
    try {
      String url = '${ApiUrl.checkIns}?page=${page ?? 1}&limit=${limit ?? 10}';
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return VisitorCheckInsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
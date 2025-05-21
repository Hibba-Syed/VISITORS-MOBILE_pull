import 'package:visitors/repo/visitor_passes/visitor_pass_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../resource/constants/api_url.dart';
class VisitorPassRepoImpl implements VisitorPassRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<VisitorPassResponseModel?> getVisitorPass({
    int? page,
    int? limit,
  }) async {
    try {
      String url =
          '${ApiUrl.visitorPasses}?page=${page ?? 1}&limit=${limit ?? 10}';
      print('Visitor Pass^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return VisitorPassResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
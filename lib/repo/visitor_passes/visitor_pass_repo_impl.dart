import 'package:visitors/repo/visitor_passes/visitor_pass_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/visitor_passes/visitor_pass_response_model.dart';
import '../../model/visitor_passes/visitor_passes_count_response_model.dart';
import '../../resource/constants/api_url.dart';
class VisitorPassRepoImpl implements VisitorPassRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<VisitorPassResponseModel?> getVisitorPasses({
    int? page,
    int? limit,
    String? keyword,
    int? unitId
  }) async {
    try {
      String url =
          '${ApiUrl.visitorPasses}?page=${page ?? 1}&limit=${limit ?? 10}&keyword=${keyword ?? ''}&unit_id=${unitId ?? ''}';
      print('Visitor Pass^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return VisitorPassResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<VisitorPassesCountResponseModel?> getVisitorPassesCount() async {
    try {
      String url = ApiUrl.visitorPassesCount;
      print('Visitor Pass count^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return VisitorPassesCountResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
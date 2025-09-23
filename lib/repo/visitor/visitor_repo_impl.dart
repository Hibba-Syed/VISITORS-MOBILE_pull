import 'package:visitors/repo/visitor/visitor_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/check_outs/check_out_visitor_response_model.dart';
import '../../model/visitor_info/delete_visitor_response_model.dart';
import '../../resource/constants/api_url.dart';

class VisitorRepoImpl implements VisitorRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<CheckOutVisitorResponseModel?> checkOutVisitors({
    required int? id,
    required Map<String, dynamic> data,
  }) async {
    try {
      String url = '${ApiUrl.checkOutVisitor}/$id';
      Map<String, dynamic> formData = {
        ...data,
        "is_mobile": true,
      };
      dynamic response =
          await _apiService.getAuthPutApiResponse(url, data: formData);
      return CheckOutVisitorResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteVisitorResponseModel?> deleteVisitor({required int? id}) async {
    try {
      dynamic response = await _apiService
          .getAuthPutApiResponse('${ApiUrl.deleteVisitor}/$id');
      return DeleteVisitorResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/check_out/check_out_response_model.dart';
import '../../resource/constants/api_url.dart';
import 'check_out_repo.dart';

class CheckOutRepoImpl implements CheckOutRepo {
  final BaseApiServices _apiService = NetworkApiServices();
  @override
  Future<CheckOutResponseModel?> getCheckOuts({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
  }) async {
    try {
      String url =
          '${ApiUrl.checkOuts}?page=${page ?? 1}&limit=${limit ?? 10}&keyword=${keyword ?? ''}&vendor_id=${vendorId ?? ''}&serviceable_type=${serviceableType ?? ''}&date_range=${(dateRange?.isNotEmpty ?? false) ? dateRange : ''}&unit_id=${unitId ?? ''}';
       print('url$url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CheckOutResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

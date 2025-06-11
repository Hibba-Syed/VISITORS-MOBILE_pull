
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/vendor/vendor_response_model.dart';
import '../../resource/constants/api_url.dart';
import 'vendors_repo.dart';

class VendorsRepoImpl implements VendorsRepo{
  final BaseApiServices _apiService = NetworkApiServices();


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
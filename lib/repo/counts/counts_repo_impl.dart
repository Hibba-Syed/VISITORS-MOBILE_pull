import 'package:visitors/data/network/base_api_services.dart';
import 'package:visitors/data/network/network_api_services.dart';
import 'package:visitors/repo/counts/counts_repo.dart';
import '../../model/count/count_response_model.dart';
import '../../resource/constants/api_url.dart';

class CountsRepoImpl implements CountsRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<CountResponseModel?> getDashboardCount()async {
    try {
      String url = ApiUrl.counts;
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CountResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }



}
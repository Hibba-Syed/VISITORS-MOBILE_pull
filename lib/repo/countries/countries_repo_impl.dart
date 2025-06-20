import 'package:visitors/repo/countries/countries_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/country/countries_response_model.dart';
import '../../resource/constants/api_url.dart';

class CountriesRepoImpl implements CountriesRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<CountriesResponseModel?> getCountries() async {
    try {
      String url = ApiUrl.countries;
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CountriesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
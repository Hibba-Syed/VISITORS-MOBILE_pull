
import 'package:visitors/repo/profile/profile_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/profile/profile_response_model.dart';
import '../../resource/constants/api_url.dart';

class ProfileRepoImpl implements ProfileRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<ProfileResponseModel?> getProfile() async {
    try {
      dynamic response = await _apiService.getAuthGetApiResponse(
        ApiUrl.profile,
      );
      print('getProfile${response.toString()}');
      return ProfileResponseModel.fromJson(response);

    } catch (e) {
      rethrow;
    }
  }

}

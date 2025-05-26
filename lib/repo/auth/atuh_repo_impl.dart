
import 'package:visitors/model/auth/login_response_model.dart';
import 'package:visitors/resource/constants/api_url.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/auth/logout_response_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final BaseApiServices _apiService = NetworkApiServices();
  @override
  Future<LoginResponseModel?> login(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(ApiUrl.login, data);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LogoutResponseModel?> logout() async {
    try {
      dynamic response =
          await _apiService.getAuthGetApiResponse(ApiUrl.logout);
      return LogoutResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

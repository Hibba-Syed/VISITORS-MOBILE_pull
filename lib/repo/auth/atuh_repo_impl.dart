

// class AuthRepoImpl implements AuthRepo {
//   final BaseApiServices _apiService = NetworkApiServices();
  // @override
  // Future<LoginResponseModel?> login(Map<String, dynamic> data) async {
  //   try {
  //     dynamic response =
  //         await _apiService.getPostApiResponse(ApiUrl.login, data);
  //     return LoginResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<UpdatePasswordResponseModel?> updatePassword(
  //     {required Map<String, dynamic> data}) async {
  //   try {
  //     dynamic response = await _apiService
  //         .getAuthPutApiResponse(ApiUrl.changePassword, data: data);
  //     return UpdatePasswordResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<VerifyEmailNotificationResponseModel?>
  //     sendVerifyEmailNotification() async {
  //   try {
  //     dynamic response = await _apiService
  //         .getAuthPostApiResponse(ApiUrl.sendVerifyEmailNotification, {});
  //     return VerifyEmailNotificationResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<ForgotPasswordResponseModel?> forgotPassword({
  //   required String email,
  // }) async {
  //   try {
  //     dynamic response = await _apiService.getAuthPostApiResponse(
  //       ApiUrl.forgotPassword,
  //       {"email": email},
  //     );
  //     return ForgotPasswordResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<LogoutResponseModel?> logout() async {
  //   try {
  //     dynamic response =
  //         await _apiService.getAuthPostApiResponse(ApiUrl.logout, {});
  //     return LogoutResponseModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
//}

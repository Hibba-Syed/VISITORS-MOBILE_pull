
import 'package:visitors/model/auth/login_response_model.dart';

import '../../model/auth/logout_response_model.dart';

abstract class AuthRepo {
  Future<LoginResponseModel?> login(Map<String, dynamic> data);
  Future<LogoutResponseModel?> logout();

}

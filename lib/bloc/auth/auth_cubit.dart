import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../model/auth/login_response_model.dart';
import '../../repo/auth/auth_repo_impl.dart';
import '../../repo/auth/auth_repo.dart';
import '../../resource/constants/strings.dart';
import '../../utils/preference_utils.dart';
import '../../utils/routes/app_routes.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  final AuthRepo _authRepo = AuthRepoImpl();

  Future<void> login(
    BuildContext context, {
    required String? communityId,
    required String? gate,
    required String? loginId,
    required String? password,
  }) async {
    emit(state.copyWith(isLoading: true));
    LoginResponseModel? loginResponse = await _authRepo.login(
      {
        'community_id': communityId,
        'gate': gate,
        'login_id': loginId,
        'password': password
      },
    ).onError(
      (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isLoading: false));

    if (loginResponse != null) {
      spUtil.token = loginResponse.accessToken;
      spUtil.communityId = communityId;
      spUtil.gate = gate;
      spUtil.password = password;
      spUtil.loginId = loginId;
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.loading, (route) => false);
     }
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('somethingWentWrongPleaseTryAgainLater'));
    }
  }
  Future<void> logout(BuildContext context) async {
    _authRepo.logout();
    spUtil.remove(Strings.keyToken);
    spUtil.remove(Strings.keyProfile);
    if (context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }
}

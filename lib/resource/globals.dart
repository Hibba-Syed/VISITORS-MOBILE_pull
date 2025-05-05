import 'package:flutter/cupertino.dart';

import '../model/profile/profile_response_model.dart';
import '../utils/preference_utils.dart';


class Globals {
  ProfileRecord? profileRecord = spUtil.profileRecord;
  String? token = spUtil.token;
  static late BuildContext appContext;
  static void setContext(BuildContext context) {
    appContext = context;
  }
}

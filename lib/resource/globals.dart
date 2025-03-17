import 'package:flutter/cupertino.dart';


class Globals {
  // ProfileRecord? profileRecord = spUtil.profileRecord;
  // String? token = spUtil.token;
  static late BuildContext appContext;
  static void setContext(BuildContext context) {
    appContext = context;
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile/profile_response_model.dart';
import '../resource/constants/strings.dart';


class PreferenceUtil {
  static PreferenceUtil? _instance;
  static Future<PreferenceUtil?> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;
  PreferenceUtil._();
  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<PreferenceUtil?> getInstance() async {
    if (_instance == null) {
      _instance = PreferenceUtil._();
      await _instance!._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool hasKey(String key) {
    Set<String>? keys = getKeys();
    return keys!.contains(key);
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf!.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return "";
    return _spf!.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf!.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  Future<bool>? remove(String key) {
    if (_beforeCheck()) return null;
    return _spf!.remove(key);
  }

  Future<bool>? clear() {
    if (_beforeCheck()) return null;
    return _spf!.clear();
  }

  ProfileRecord? get profileRecord {
    var profileJson = getString(Strings.keyProfile);
    if (profileJson != null) {
      return ProfileRecord.fromJson(jsonDecode(profileJson));
    }
    return null;
  }

  set profileRecord(ProfileRecord? profileRecord) {
    putString(Strings.keyProfile, jsonEncode(profileRecord?.toJson()));
  }

  String? get token {
    return getString(Strings.keyToken);
  }

  set token(String? token) {
    if (token != null) {
      putString(Strings.keyToken, token);
    }
  }
  String? get communityId {
    return getString(Strings.keyCommunityId);
  }

  set communityId(String? communityId) {
    if (communityId != null) {
      putString(Strings.keyCommunityId, communityId);
    }
  }
  String? get gate {
    return getString(Strings.keyGate);
  }

  set gate(String? gate) {
    if (gate != null) {
      putString(Strings.keyGate, gate);
    }
  }

 String? get loginId {
    return getString(Strings.keyLoginId);
  }

  set loginId(String? loginId) {
    if (loginId != null) {
      putString(Strings.keyLoginId, loginId);
    }
  }

  String? get password {
    return getString(Strings.keyPassword);
  }

  set password(String? password) {
    if (password != null) {
      putString(Strings.keyPassword, password);
    }
  }

}

late PreferenceUtil spUtil;
initPreferences() async {
  spUtil = (await PreferenceUtil.getInstance())!;
}

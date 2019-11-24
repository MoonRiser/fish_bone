import 'dart:convert';

import 'package:fish_bone/models/cacheConfig.dart';
import 'package:fish_bone/models/profile.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'net_cache.dart';
import 'network_api.dart';

class Global {
  static Profile profile = new Profile();
  static SharedPreferences _prefs;
  static NetCache netCache = new NetCache();

  static Future init() async {
    new Net().init();
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
     //   print(profile.lastLogin);
      } catch (e) {
        print("23333$e");
      }
    }
    profile.config = profile.config ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 30;
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}

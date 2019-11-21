import 'package:fish_bone/common/global.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileChangeNotifier extends ChangeNotifier {

  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UIState extends ProfileChangeNotifier {
  User get user => _profile.currentUser;
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.id != _profile.currentUser?.id) {
      _profile.lastLogin = _profile.currentUser?.acco;
      _profile.currentUser = user;
      Global.netCache.cache.clear();
    }

    if(_profile.lastLogin==null){
      _profile.lastLogin = _profile.currentUser.acco;
    }
    notifyListeners();
  }



  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void changeDarkMode() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

import 'package:fish_bone/models/bean.dart';

import 'network_api.dart';

class Global {
  User _currentUser;

// 静态私有成员，没有初始化
  static Global _instance;

  // 单例公开访问点
  factory Global() => _sharedInstance();

  // 私有构造函数
  Global._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static Global _sharedInstance() {
    if (_instance == null) {
      _instance = Global._();
    }
    return _instance;
  }


  User get currentUser => _currentUser;

  set currentUser(User value) {
    _currentUser = value;
  }

  static void init() {
    new Net().init();
  }
}

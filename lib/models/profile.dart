import 'package:fish_bone/common/net_cache.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/models/cacheConfig.dart';

class Profile {
  Profile();

  User currentUser;
  CacheConfig config;
  String lastLogin;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile()
      ..config = json['config'] == null
          ? null
          : CacheConfig.fromJson(json['config' as Map<String, dynamic>])
      ..currentUser = json['currentUser'] == null
          ? null
          : User.fromJson(json['currentUser'] as Map<String, dynamic>)
      ..lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'currentUser': this.currentUser,
        'config': this.config,
        'lastLogin': this.lastLogin
      };
}

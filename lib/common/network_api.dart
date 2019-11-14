import 'dart:typed_data';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:fish_bone/common/global.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Net {
  BuildContext _context;
  var cookieJar = CookieJar();

// 静态私有成员，没有初始化
  static Net _instance;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://192.168.137.1:8080/fish_boom/',
  ));

  // 单例公开访问点
  factory Net() => _sharedInstance();

  // 私有构造函数
  Net._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static Net _sharedInstance() {
    if (_instance == null) {
      _instance = Net._();
    }
    return _instance;
  }

//
//  dio.interceptors.add(CookieManager(cookieJar));
//  // Print cookies
//  print(cookieJar.loadForRequest(Uri.parse("https://baidu.com/")));

  void init() {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Uint8List> getCaptcha() async {
    var url = "/getCaptcha";
    Response<List<int>> rs = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes), //设置接收类型为bytes
    );

//    String  source = response.data as String;
//    var list = new List<int>();
//    source.runes.forEach((rune) {
//
//      if (rune >= 0x10000) {
//        rune -= 0x10000;
//        int firstWord = (rune >> 10) + 0xD800;
//        list.add(firstWord >> 8);
//        list.add(firstWord & 0xFF);
//        int secondWord = (rune & 0x3FF) + 0xDC00;
//        list.add(secondWord >> 8);
//        list.add(secondWord & 0xFF);
//      } else {
//        list.add(rune >> 8);
//        list.add(rune & 0xFF);
//      }
//    });
//    Uint8List bytes = Uint8List.fromList(list);

    // print(cookieJar.loadForRequest(Uri.parse("http://192.168.137.1:8080/fish_boom/getCaptcha/")));
    return Uint8List.fromList(rs.data);
  }

  Future<String> login(String acco, String pwd, String captchaCode) async {
    var url = '/login?verifyCode=$captchaCode';
    var r = await dio.post(url, data: {"acco": acco, "password": pwd});
    Map<String, dynamic> json = r.data as Map<String, dynamic>;

    if (json['list'] != null) {
      var user = User.fromJson(json['list']);
      Global().currentUser = user;
      return 'true';
    } else {
      return json['message'];
    }
  }
}

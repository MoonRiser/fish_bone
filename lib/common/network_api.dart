import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fish_bone/common/global.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Net {
  BuildContext context;
  var cookieJar = new CookieJar();

// 静态私有成员，没有初始化
  static Net _instance;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://localhost:8080/fish_boom/',
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
//    Directory appDocDir = await getApplicationDocumentsDirectory();
//    String appDocPath = appDocDir.path;
//    var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(Global.netCache);
  }

  Future<Uint8List> getCaptcha() async {
    var url = "/getCaptcha";
    Response<List<int>> rs = await dio.get<List<int>>(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          extra: {"noCache": true}), //设置接收类型为bytes
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
      if (context != null) {
        Provider.of<UIState>(context, listen: false).user = user;
      }
      return 'true';
    } else {
      return json['message'];
    }
  }

  Future<Map<String, dynamic>> getTaskList(
      int page, int pageSize, int taskType, String status, bool refresh) async {
    var url = "/task/list";
    Response<dynamic> response = await dio.get(
      url,
      options: Options(extra: {"list": true, "refresh": refresh}),
      queryParameters: {
        "start": page,
        "size": pageSize,
        "task_type": taskType,
        "status": status,
        "sorters": "{\"column\": \"end_Date\", \"direction\": \"asc\"}"
      },
    ); //设置接收类型为bytes
    //print(response.data['list']);
    return response.data;
  }

  Future<Map<String, dynamic>> getProjList(
      int page, int pageSize, String status, bool refresh) async {
    var url = "/proj/list";
    Response<dynamic> response = await dio.get(
      url,
      options: Options(extra: {"list": true, "refresh": refresh}),
      queryParameters: {
        "start": page,
        "size": pageSize,
        "status": status,
        "sorters": "{\"column\": \"end_Date\", \"direction\": \"asc\"}"
      },
    ); //设置接收类型为bytes
    //print(response.data['list']);
    return response.data;
  }

  Future<Map<String, dynamic>> getNotiList([bool refresh]) async {
    var url = '/opera/list';
    Response<dynamic> response = await dio.get(
      url,
      options: Options(extra: {"list": true, "refresh": refresh}),
    );
    return response.data;
    // print(response.data);
  }

  Future<Map<String, dynamic>> getNotiListById(int id, String type) async {
    var url = '/opera/listById';
    Response<dynamic> response = await dio.get(
      url,
      queryParameters: {
        "type": type,
        "id": id,
      },
      options: Options(extra: {
        "noCache": true,
      }),
    );
    return response.data;
    // print(response.data);
  }

  Future<Map<String, dynamic>> getTaskListInProj(int pid,
      [bool refresh]) async {
    var url = '/proj/listTask';
    Response<dynamic> response = await dio.get(
      url,
      options: Options(extra: {"list": true, "refresh": refresh}),
      queryParameters: {
        "pid": pid,
      },
    );
    //   print(response.data);
    return response.data;
  }

  Future<String> addNoti(int subjectID, String content, String type) async {
    var url = '/opera/add';

    Response<dynamic> response = await dio.post(
      url,
      data: {
        "subject_id": subjectID,
        "content": content,
        "type": type,
      },
      options: Options(extra: {"noCache": true}),
    );
    var msg = response.data as Map;
    print(response.data);
    return msg["list"];
  }
}

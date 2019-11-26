import 'dart:core';

import 'package:fish_bone/common/global.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:fish_bone/widgets/card_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

var title = ["人·车·生活", "技术·日产", "东风南方", "人生即·PLAY", "红色天鹅绒", "此刻微风起"];

var images = [
  "images/image_01.png",
  "images/image_02.png",
  "images/image_03.png",
  "images/play.jpg",
  "images/the_red.jpg",
  "images/yuner.jpg",
];

class SettingPage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<SettingPage> {
  var currentPage = images.length - 1.0;

  User user = Global.profile.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<UIState>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: _state.themeMode == ThemeMode.dark
              ? LinearGradient(
                  colors: [
                      Color(0xFF1b1e44),
                      Color(0xFF2d3447),
                    ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)
              : LinearGradient(
                  colors: [
                      Colors.blueGrey[200],
                      Colors.blueGrey[700],
                    ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('小明',
                        //user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.all_inclusive,
                        //  size: 12.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _state.changeDarkMode();
                      },
                    )
                  ],
                ),
              ),
              Stack(children: <Widget>[
                CardScrollWidget(
                  images,
                  titles: title,
                  callback: (index) {
                    Fluttertoast.showToast(
                        msg: "当前点击的是第${index}页", gravity: ToastGravity.CENTER);
                  },
                ),
              ]),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await logout(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> logout(BuildContext context) async {
    bool isLogout = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("退出登陆"),
            content: Text("确定退出登陆吗？"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("是的"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
    if (isLogout) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    }
  }
}

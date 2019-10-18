import 'dart:ui';

import 'package:fish_bone/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  var _controllerNickName = new TextEditingController();
  var _controllerAccout = new TextEditingController();
  var _controllerPWD = new TextEditingController();
  var _controllerVCode = new TextEditingController();
  var _psdVisible = false;
  var isRegister = true;
  bool isButtonEnable = false;
  var focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isButtonEnable = true;
        });
      } else {
        setState(() {
          isButtonEnable = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("欢迎来到鱼骨"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  isRegister ? '注册' : '登陆',
                  textScaleFactor: 1.5,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              FlatButton(
                child: Text(
                  isRegister ? '有账号？去登陆' : '去注册',
                  style: TextStyle(color: Styles.colorAccent),
                ),
                onPressed: () {
                  setState(() {
                    isRegister = !isRegister;
                  });
                },
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: BoxDecoration(
                boxShadow: [Styles.cardShadow],
                borderRadius: Styles.cardBorderRadius,
                color: ThemeData.light().scaffoldBackgroundColor),
            child: Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    isRegister
                        ? TextFormField(
                            controller: _controllerNickName,
                            decoration: InputDecoration(
                                labelText: '昵称',
                                hintText: 'nickname here',
                                prefixIcon: Icon(Icons.person)),
                            validator: (v) {
                              return v.trim().length > 1 ? null : '昵称长度>=2';
                            },
                          )
                        : Row(
                            children: <Widget>[
                              Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 2,
                                child: Image.asset(
                                  "images/validate_code.png",
                                  height: 48,
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: _controllerVCode,
                                  decoration:
                                      InputDecoration(labelText: '验证码:'),
                                ),
                              )
                            ],
                          ),
                    TextFormField(
                      controller: _controllerAccout,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: '账号',
                        hintText: 'account here',
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                      validator: (v) {
                        return v.trim().length > 7 ? null : '账号长度>=8';
                      },
                    ),
                    TextFormField(
                      controller: _controllerPWD,
                      obscureText: _psdVisible,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: '密码',
                        hintText: 'password here',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(_psdVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _psdVisible = !_psdVisible;
                              });
                            }),
                      ),
                      validator: (v) {
                        return v.trim().length > 7 ? null : '密码长度>=8';
                      },
                    )
                  ],
                )),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: isRegister
                  ? Styles.getLongButton(
                      context: context,
                      label: '注册',
                      isEnable: isButtonEnable,
                      callback: () {
                        print('login');
                      })
                  : Styles.getLongButton(
                      context: context,
                      label: '登陆',
                      isEnable: isButtonEnable,
                      callback: () {
                        print('register');
                      })),
        ],
      ),
    );
  }
}

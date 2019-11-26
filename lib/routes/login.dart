import 'dart:typed_data';
import 'dart:ui';

import 'package:fish_bone/common/global.dart';
import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/common/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  var _psdVisible = true;
  var isRegister = true;
  bool isButtonEnable = false;
  bool currentStatus;
  List<int> imgBytes;
  Net _net;

  @override
  void initState() {
    super.initState();
    _controllerAccout.text = Global.profile.lastLogin;
    _net = new Net()..context = context;
    _setCaptChaCode();
  }

  @override
  Widget build(BuildContext context) {
    // _net = new Net(context);
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 8,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Form(
                  key: _formKey,
                  autovalidate: true,
                  onChanged: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      currentStatus = true;
                    } else {
                      currentStatus = false;
                    }
                    if (currentStatus != isButtonEnable) {
                      isButtonEnable = currentStatus;
                      setState(() {});
                    }
                  },
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
                          : SizedBox(
                              height: 80,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: imgBytes.isEmpty
                                        ? Center(
                                            child: Text("loading..."),
                                          )
                                        : GestureDetector(
                                            child: Image.memory(
                                              Uint8List.fromList(imgBytes),
                                              fit: BoxFit.fill,
                                            ),
                                            onTap: () {
                                              _setCaptChaCode();
                                            },
                                          ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      controller: _controllerVCode,
                                      validator: (v) {
                                        return v.trim().length == 5
                                            ? null
                                            : '长度=5';
                                      },
                                      decoration:
                                          InputDecoration(labelText: '验证码:'),
                                    ),
                                  )
                                ],
                              ),
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: isRegister
                ? Styles.getLongButton(
                    context: context,
                    label: '注册',
                    isEnable: isButtonEnable,
                    callback: () {
                      // Navigator.of(context).pushNamed("home");
                      //print('login');
                    })
                : Styles.getLongButton(
                    context: context,
                    label: '登陆',
                    isEnable: isButtonEnable,
                    callback: () {
                      _login();
                      // Navigator.of(context).pushNamed("home");
                    }),
          ),
        ],
      ),
    );
  }

  void _setCaptChaCode() async {
    imgBytes = await _net.getCaptcha();
    setState(() {});
  }

  void _login() async {
    if ((_formKey.currentState as FormState).validate()) {
      String msg = await _net.login(_controllerAccout.text.trim(),
          _controllerPWD.text.trim(), _controllerVCode.text.trim());
      //    print(msg);
      if ('true' == msg) {
        Navigator.of(context).popAndPushNamed("home");
      } else {
        Fluttertoast.showToast(msg: '登陆失败：$msg', gravity: ToastGravity.CENTER);
      }
      //验证通过提交数据

    }
  }
}

import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
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
  var _psdVisible = false;
  var isRegister = true;
  bool isButtonEnable = false;
  var focusNode = new FocusNode();
  List<int> imgBytes;
  Net _net;

  @override
  void initState() {
    super.initState();
    _net = new Net();
    _setCaptChaCode();
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
    // _net = new Net(context);
    return Scaffold(
      //resizeToAvoidBottomInset: true,
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
                                    flex: 5,
                                    child: imgBytes.isEmpty
                                        ? Center(
                                            child: Text("loading..."),
                                          )
                                        : GestureDetector(
                                            child: Image.memory(
                                                Uint8List.fromList(imgBytes),fit: BoxFit.fill,),
                                            onTap: () {
                                              _setCaptChaCode();
                                            },
                                          ),
                                  ),
                                  Spacer(flex: 1,),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      controller: _controllerVCode,
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
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: isRegister
                  ? Styles.getLongButton(
                      context: context,
                      label: '注册',
                      isEnable: isButtonEnable,
                      callback: () {
                        Navigator.of(context).pushNamed("home");
                        //print('login');
                      })
                  : Styles.getLongButton(
                      context: context,
                      label: '登陆',
                      isEnable: isButtonEnable,
                      callback: () {
                        _login();
                        // Navigator.of(context).pushNamed("home");
                      })),
        ],
      ),
    );
  }

  void _setCaptChaCode() async {
    var list = await _net.getCaptcha();
    imgBytes = list;
    setState(() {});
  }

  void _login() async {
    if ((_formKey.currentState as FormState).validate()) {
      String msg = await _net.login(
          _controllerAccout.text, _controllerPWD.text, _controllerVCode.text);
      print(msg);
      if ('true'== msg) {
        Navigator.of(context).pushNamed("home");
      }else{
        Fluttertoast.showToast(msg: '登陆失败：$msg',gravity: ToastGravity.CENTER);
      }
      //验证通过提交数据

    }
  }
}

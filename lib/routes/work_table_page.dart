
import 'package:flutter/material.dart';


class SettingPage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置和其他'),
      ),
    );
  }
}

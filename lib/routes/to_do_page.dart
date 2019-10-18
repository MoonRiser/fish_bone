

import 'package:flutter/material.dart';


class TaskDisplayPage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('展示任务和项目'),
      ),
    );
  }
}

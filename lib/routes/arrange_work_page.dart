
import 'package:flutter/material.dart';


class TaskCreatePage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('创建任务和项目'),
      ),
    );
  }
}

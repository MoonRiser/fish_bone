import 'package:fish_bone/routes/tabs/task_tab.dart';
import 'package:flutter/material.dart';

class TaskDisplayPage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskDisplayPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  var tabs = <Widget>[Text('全部'), Text('我负责'), Text("我创建"), Text("抄送我")];
  int _index = 0;
  var _appBarColor;

  final ColorTween colorTween =
      new ColorTween(begin: Colors.blue, end: Colors.indigo);

  @override
  void initState() {
    super.initState();
    controller = new TabController(initialIndex: 0, length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          _index = controller.index;
        //  print(_index);
        });
      });
    Animation animation = controller.animation;
    animation.addListener(() {
      // print(animation.value);
      setState(() {
        _appBarColor = colorTween.evaluate(animation);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          TaskTabView(_index),
          TaskTabView(_index),
          TaskTabView(_index),
          TaskTabView(_index),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('展示任务'),
        backgroundColor: _appBarColor,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.pushNamed(context, "taskCreate");
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: controller,
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

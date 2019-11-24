import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/routes/tabs/task_tab.dart';
import 'package:fish_bone/widgets/item_task.dart';
import 'package:flukit/flukit.dart';
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
  var taskData = <int, List<Task>>{0: [], 1: [], 2: [], 3: []};

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
          _buildList(),
          _buildList(),
          _buildList(),
          _buildList(),
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

  Widget _buildList() {
    return InfiniteListView<Task>(
      onRetrieveData: (int page, List<Task> items, bool refresh) async {
        if (taskData[_index].length > 0 && refresh == true) {
          taskData[_index].clear();
        }

        //把请求到的新数据添加到items中
        var json =
            await Net().getTaskList(page, 12, _index, "running", refresh);
        var jsonTask = json['list'] as List;
        var sublist = jsonTask.map((v) => Task.fromJson(v)).toList();
        taskData[_index].addAll(sublist);
        items.addAll(sublist);
        print(items.length.toString() + ":" + sublist.length.toString());
        return (sublist.length > 0) && (sublist.length % 12 == 0);
        // return data.length > 0 && data.length % 5 == 0;
      },
      itemBuilder: (List list, int index, BuildContext context) {
        var task = list[index] as Task;
        return GestureDetector(
          child: TaskItemView(new TaskBean(task.name, task.status, task.startDate)),
          onTap: () async {
            Navigator.of(context)
                .pushNamed("taskDetail", arguments: taskData[_index][index]);
          },
        );
        // return
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

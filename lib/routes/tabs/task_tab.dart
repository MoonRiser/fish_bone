import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_task.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TaskTabView extends StatelessWidget {
  TaskTabView(this.index);

  final int index;

  final data = <TaskBean>[];
  final taskData = <Task>[];

  @override
  Widget build(BuildContext context) {
    //  print(index);

    //  print(data.length);
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return InfiniteListView<TaskBean>(
      onRetrieveData: (int page, List<TaskBean> items, bool refresh) async {
        //把请求到的新数据添加到items中
        var json =
            await Net().getTaskList(page + 1, 8, index, 'running', refresh);
        var jsonTask = json['list'] as List;
        taskData.addAll(jsonTask.map((v) => Task.fromJson(v)).toList());
        items.addAll(taskData
            .map((v) => TaskBean(v.name, v.status, v.startDate))
            .toList());
        return false;
        // return data.length > 0 && data.length % 5 == 0;
      },
      itemBuilder: (List list, int index, BuildContext context) {
        return GestureDetector(
          child: TaskItemView(list[index]),
          onTap: () async {
            Navigator.of(context).pushNamed("taskDetail", arguments: taskData[index]);
          },
        );
        // return
      },
    );
  }
}

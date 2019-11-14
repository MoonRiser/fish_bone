import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_task.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class TaskTabView extends StatelessWidget {
  TaskTabView(this.index);

  final int index;

  final data = <TaskBean>[];

  @override
  Widget build(BuildContext context) {
  //  print(index);
    for (int i = 0; i < 5 + 2 * index; i++) {
      data.add(new TaskBean("感谢使用鱼骨任务和项目协作系统！", "进行中", "08-2$i"));
    }

  //  print(data.length);
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    return InfiniteListView<TaskBean>(
      onRetrieveData: (int page, List<TaskBean> items, bool refresh) async {
        //把请求到的新数据添加到items中
        items.addAll(data);
        return false;
        // return data.length > 0 && data.length % 5 == 0;
      },
      itemBuilder: (List list, int index, BuildContext context) {
        return GestureDetector(
          child: TaskItemView(list[index]),
          onTap: () {
            Navigator.of(context).pushNamed("taskDetail",arguments: index );
          },
        );
        // return
      },
    );
  }
}

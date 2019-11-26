import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:fish_bone/widgets/item_task.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class ProjectDetail extends StatefulWidget {
  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  var _isList = false;
  var controller = new TextEditingController();
  var data = <Notifi>[];
  Project currentProj;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    currentProj = ModalRoute.of(context).settings.arguments as Project;
    return Scaffold(
      appBar: AppBar(
        title: Text("项目详情"),
        actions: <Widget>[
          Switch(
            value: _isList,
            onChanged: (isChanged) {
              _isList = isChanged;
              setState(() {});
            },
          )
        ],
      ),
      bottomNavigationBar: _isList
          ? null
          : BottomAppBar(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: controller,
                        ),
                      )),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                      onPressed: () {
//                        data.insert(
//                            0,
//                            new NotiBean(0, '小明', controller.text, "SS501",
//                                TimeOfDay.now().toString()));
                        controller.clear();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "[50%] 鱼骨项目",
                  textScaleFactor: 1.6,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              children: <Widget>[
                Spacer(),
                Text(
                  "起讫日期：2019/11/14-2019/12/14",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              //  padding: EdgeInsets.symmetric(vertical: 16),
              child: _isList
                  ? _buildList()
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ExpansionPanelList.radio(
                            expansionCallback: (index, isExpand) {},
                            children: <ExpansionPanelRadio>[
                              ExpansionPanelRadio(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text("项目经理"),
                                  );
                                },
                                body: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ListTile(title: Text("$index"));
                                  },
                                  shrinkWrap: true,
                                ),
                                value: 0,
                              ),
                              ExpansionPanelRadio(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text("项目成员"),
                                  );
                                },
                                body: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ListTile(title: Text("$index"));
                                  },
                                  shrinkWrap: true,
                                ),
                                value: 1,
                              ),
                              ExpansionPanelRadio(
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text("抄送人"),
                                  );
                                },
                                body: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ListTile(title: Text("$index"));
                                  },
                                  shrinkWrap: true,
                                ),
                                value: 2,
                              ),
                            ],
                          );
                        } else {
                          return NotiItem(data[index - 1]);
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: data.length + 1,
                      shrinkWrap: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() {
//    for (int i = 0; i < 5; i++) {
//      data.add(new NotiBean(i,'小明', "注意你的bug，他会爆发", 'SS5${i}1', "1989-0$i/04"));
//    }
  }

  Widget _buildList() {
    return InfiniteListView<Task>(
      onRetrieveData: (int page, List<Task> items, bool refresh) async {
        //把请求到的新数据添加到items中
        var json = await Net().getTaskListInProj(currentProj.id, refresh);
        var jsonTask = json['list'] as List;
        var sublist = jsonTask.map((v) => Task.fromJson(v)).toList();
        items.addAll(sublist);
      //  print("items:${items.length}");
        //      print(items.length.toString() + ":" + sublist.length.toString());
        //   return (sublist.length > 0) && (sublist.length % 12 == 0);
        return false;
      },
      itemBuilder: (List list, int index, BuildContext context) {
        var task = list[index] as Task;
        return GestureDetector(
          child: TaskItemView(
              new TaskBean(task.name, task.status, task.startDate)),
          onTap: () {
            Navigator.of(context)
                .pushNamed("taskDetail", arguments: list[index]);
          },
        );
        // return
      },
    );
  }
}

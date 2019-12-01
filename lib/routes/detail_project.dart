import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/common/widgets_my.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:fish_bone/widgets/item_task.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProjectDetail extends StatefulWidget {
  final Project project;

  ProjectDetail(this.project);

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  var _isList = false;
  var controller = new TextEditingController();
  var data = <Notifi>[];
  Project currentProj;
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    currentProj = widget.project;
    getNotiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("项目详情"),
        actions: <Widget>[
          Switch(
            value: _isList,
            onChanged: (isChanged) {
              _isList = isChanged;
              setState(() {});
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem(
                  child: Text("删除"),
                  value: "delete",
                )
              ];
            },
            onSelected: (type) {
              if (type == "delete") {
                //    print("you tap delete");
                //此处进行删除操作
              }
            },
          ),
        ],
      ),
      body: SlidingUpPanel(
        panel: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Provider.of<UIState>(context).headerColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                ),
                child: MyCommonWidget().getHeader(
                  controller,
                  focusNode,
                  scrollController,
                  context,
                  NotiCallback(getNotiData, setNotiData),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                      controller: scrollController,
                      itemBuilder: (context, index) => NotiItem(data[index]),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: data.length),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "[${currentProj.percent}] ${currentProj.name}",
                textScaleFactor: 1.6,
              ),
              Row(
                children: <Widget>[
                  Spacer(),
                  Text(
                    "起讫日期：${currentProj.startDate.split(" ")[0]}--${currentProj.endDate.split(" ")[0]}",
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
                    : SingleChildScrollView(
                        child: ExpansionPanelList.radio(
                          expansionCallback: (index, isExpand) {},
                          children: <ExpansionPanelRadio>[
                            ExpansionPanelRadio(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                        title: Text("项目经理"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(currentProj.pm.name),
                                    ),
                                  ],
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
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                        title: Text("抄送人"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(MyCommonWidget.getPeopleName(
                                          currentProj.cc)),
                                    ),
                                  ],
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
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                        title: Text("项目成员"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(MyCommonWidget.getPeopleName(
                                          currentProj.partner)),
                                    ),
                                  ],
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
                        ),
                      ),
              ),
            ],
          ),
        ),
        backdropEnabled: true,
        minHeight: 72,
        maxHeight: 560,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
    );
  }

  Future getNotiData() async {
    var json = await Net().getNotiListById(widget.project.id, "project");
    var subList = json["list"] as List;
    // print(subList);
    data.clear();
    data.addAll(subList
        .map((v) => Notifi.fromJson(v)
          ..subjectName = widget.project.name
          ..subjectId = widget.project.id
          ..type = "project")
        .toList());
    setState(() {});
  }

  Future<String> setNotiData() async {
    return await Net().addNoti(widget.project.id, controller.text, "project");
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

import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/common/widgets_my.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TaskDetail extends StatefulWidget {
  final Task task;

  TaskDetail(this.task);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  var data = <Notifi>[];
  var controller = new TextEditingController();
  ScrollController scrollController = new ScrollController();
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    getNotiData();
  }

  @override
  Widget build(BuildContext context) {
    var task = widget.task;
    // print(task);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
        title: Text('待办'),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true,
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
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  task.name,
                  //       '[G001]感谢您使用鱼骨任务和项目协作系统！',
                  textScaleFactor: 2,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Color(0x339E9E9E),
                child: Row(
                  children: <Widget>[
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "负责人： "),
                      TextSpan(
                          text: MyCommonWidget.getPeopleName(task.ff),
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Fluttertoast.showToast(msg: "我是小明");
                            }),
                      TextSpan(text: "\n优先级： "),
                      TextSpan(
                          text: task.priority,
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
                    Spacer(
                      flex: 1,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: "结束时间： "),
                      TextSpan(
                          text: task.endDate.split(" ")[0],
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(text: "\n抄送人： "),
                      TextSpan(
                          text: MyCommonWidget.getPeopleName(task.cc),
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
                  ],
                ),
              ),
              Expanded(
                //  padding: EdgeInsets.symmetric(vertical: 16),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        task.content,
                        textScaleFactor: 1.4,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "任务执行\n${task.creator}",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Spacer(
                          flex: 8,
                        ),
                        RaisedButton(
                          child: Text('开始解决'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        RaisedButton(
                          child: Text('完成任务'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          //  child: Text(args.toString()),
        ),
        minHeight: 72,
        maxHeight: 560,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
    );
  }

  Future getNotiData() async {
    var json = await Net().getNotiListById(widget.task.id, "task");
    var subList = json["list"] as List;
    // print(subList);
    data.clear();
    data.addAll(subList
        .map((v) => Notifi.fromJson(v)
          ..subjectName = widget.task.name
          ..subjectId = widget.task.id
          ..type = "task")
        .toList());
    setState(() {});
  }

  Future<String> setNotiData() async {
    return await Net().addNoti(widget.task.id, controller.text, "task");
  }


}

import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/common/utils.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class TaskDetail extends StatefulWidget {
  final Task task;

  TaskDetail(this.task);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  var data = <Notifi>[];
  var controller = new TextEditingController();
  var focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var task = widget.task;
    // print(task);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
        title: Text('待办'),
      ),
//      bottomNavigationBar: BottomAppBar(
//        child: Row(
//          children: <Widget>[
//            Expanded(
//                flex: 5,
//                child: Padding(
//                  padding: EdgeInsets.symmetric(horizontal: 8),
//                  child: TextField(
//                    controller: controller,
//                  ),
//                )),
//            Container(
//              width: 1,
//              height: 40,
//              color: Colors.grey,
//            ),
//            Expanded(
//              flex: 1,
//              child: IconButton(
//                icon: Icon(
//                  Icons.send,
//                  color: Colors.grey,
//                ),
//                onPressed: () {
//                  if (controller.text.length > 0) {
//                    setState(() {
////                      data.insert(
////                          0,
////                          new Notifi(55,'XWenc', controller.text, "SS501",
////                              TimeOfDay.now().toString()));
//                      controller.clear();
//                    });
//                  }
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
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
                            text: getPeopleName(task.ff),
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
                            text: getPeopleName(task.cc),
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ])),
                    ],
                  ),
                ),
                Expanded(
                  //  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            task.content,
                            textScaleFactor: 1.4,
                          ),
                        );
                      } else if (index == 1) {
                        return Row(
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
                        );
                      } else {
                        return data.length > 0
                            ? NotiItem(data[index - 2])
                            : Container();
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: data.length > 0 ? data.length + 2 : 2,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
            //  child: Text(args.toString()),
          ),
          DraggableScrollableSheet(
              //  key:GlobalKey(),
              initialChildSize: 0.14,
              minChildSize: 0.1,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, -1),
                          color: Colors.black26,
                          blurRadius: 8.0),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: MySliverPersistentHeaderDelegate(
                            minHeight: 68,
                            maxHeight: 68,
                            child: getHeader(scrollController),
                            //   color: Colors.transparent,
                            color: Provider.of<UIState>(context).headerColor),
                      ),
                      SliverList(
                        delegate:
                            new SliverChildBuilderDelegate((context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                color: Theme.of(context).cardColor,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: NotiItem(data[index]),
                              ),
                             SizedBox(height: 6,),
                            ],
                          );
                        }, childCount: data.length),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
      //  bottomSheet: ,
    );
  }

  Widget getHeader(ScrollController scrollController) {
    focus.addListener(() {
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    });

    var header = Column(
      children: <Widget>[
        Container(
          height: 12,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).textTheme.title.color),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  "评论",
                  textScaleFactor: 1.4,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: InputDecoration(filled: true,border: InputBorder.none),
                  focusNode: focus,
                  controller: controller,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (controller.text.trim().length < 1) return;
                    var msg = await Net()
                        .addNoti(widget.task.id, controller.text, "task");
                    if (msg == "评论成功") {
                      controller.clear();
                      getData();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return header;
  }

  void getData() async {
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

  String getPeopleName(List<User> list) {
    switch (list.length) {
      case 0:
        return "";
      case 1:
        return "${list[0].name}";
      case 2:
        return "${list[0].name}\\${list[1].name}";
    }

    return "${list[0].name}\\${list[1].name}...";
  }
}

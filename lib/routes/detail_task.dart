import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  var data = <Notifi>[];
  var controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context).settings.arguments as Task;
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
      bottomNavigationBar: BottomAppBar(
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
                  if (controller.text.length > 0) {
                    setState(() {
//                      data.insert(
//                          0,
//                          new Notifi(55,'XWenc', controller.text, "SS501",
//                              TimeOfDay.now().toString()));
                      controller.clear();
                    });
                  }
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
                    return NotiItem(data[index - 2]);
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: data.length + 2,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
        //  child: Text(args.toString()),
      ),
    );
  }

  void getData() {
//    for (int i = 0; i < 5; i++) {
//      data.add(new NotiBean(i,'小红', "注意你的bug，他会爆发", 'SS5${i}1', "1989-0$i/04"));
//    }
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

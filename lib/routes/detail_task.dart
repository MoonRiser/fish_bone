import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  var data = <NotiBean>[];
  var controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context).settings.arguments;
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
                      data.insert(0, new NotiBean('小明', controller.text, "SS501",
                          TimeOfDay.now().toString()));
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
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                '[G001]感谢您使用鱼骨任务和项目协作系统！',
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
                        text: "小明",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    TextSpan(text: "\n优先级： "),
                    TextSpan(
                        text: "普通",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ])),
                  Spacer(
                    flex: 1,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "结束时间： "),
                    TextSpan(
                        text: "2019-08-21",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    TextSpan(text: "\n抄送人： "),
                    TextSpan(
                        text: "未设置",
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
                        "千古江山，英雄无觅，孙仲谋处 \n 舞榭歌台，风流总被、雨打风吹去。\n斜阳草树，寻常巷陌，人道寄奴曾住。\n想当年，金戈铁马，气吞万里如虎。\n元嘉草草，封狼居胥，赢得仓皇北顾。\n四十三年，望中犹记，烽火扬州路。可堪回首，佛狸祠下，一片神鸦社鼓。\n凭谁问：廉颇老矣，尚能饭否？",
                        textScaleFactor: 1.4,
                      ),
                    );
                  } else if (index == 1) {
                    return Row(
                      children: <Widget>[
                        Text(
                          "任务执行\n小明",
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
    for (int i = 0; i < 5; i++) {
      data.add(new NotiBean('小明', "注意你的bug，他会爆发", 'SS5${i}1', "1989-0$i/04"));
    }
  }
}

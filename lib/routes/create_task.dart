import 'package:flutter/material.dart';

class TaskCreatePage extends StatefulWidget {
  @override
  _TaskCreatePageState createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  var controller = new TextEditingController();
  var _time = '选择起始日期';
  bool isFirstTime = true;
  var startTime;
  var endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建任务"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "任务主题（必填）",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  expansionCallback: (index, isExpand) {},
                  children: <ExpansionPanelRadio>[
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text("负责人"),
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
                      headerBuilder: (BuildContext context, bool isExpanded) {
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
                      value: 1,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text("起止时间"),
                        );
                      },
                      body: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(_time,textScaleFactor: 1.4,),
                        ),
                        onTap: () async {
                          if (isFirstTime) {
                            startTime = await _showDatePicker1();
                            isFirstTime = false;
                            _time = startTime.toString().split(" ")[0] + "  选择终止日期";
                          } else {
                            endTime = await _showDatePicker1(startTime);
                            _time =
                                startTime.toString().split(" ")[0] + " 到 " + endTime.toString().split(" ")[0];
                            isFirstTime = true;
                          }
                          setState(() {});
                        },
                      ),
                      value: 3,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text("任务优先级"),
                        );
                      },
                      body: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text("$index"));
                        },
                        shrinkWrap: true,
                      ),
                      value: 4,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text("所属项目"),
                        );
                      },
                      body: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text("$index"));
                        },
                        shrinkWrap: true,
                      ),
                      value: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(48),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.save),
          onPressed: () {},
        ),
      ),
    );
  }

  Future<DateTime> _showDatePicker1([DateTime dateTime]) {
    bool isStart = (dateTime == null) ? true : false;
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: isStart ? date : dateTime,
      firstDate: isStart ? date.subtract(Duration(days: 30)) : dateTime,
      lastDate: isStart ? date.add(//未来30天可选
          Duration(days: 30)) : dateTime.add(//未来30天可选
          Duration(days: 30)),
    );
  }

}

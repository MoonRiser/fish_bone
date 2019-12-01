import 'package:fish_bone/common/widgets_my.dart';
import 'package:flutter/material.dart';

class ProjectCreatePage extends StatefulWidget {
  @override
  _ProjectCreatePageState createState() => _ProjectCreatePageState();
}

class _ProjectCreatePageState extends State<ProjectCreatePage> {
  var controller = new TextEditingController();
  var _time = '选择起始日期';
  bool isFirstTime = true;
  var startTime;
  var endTime;
  var _withTree = false;
  var pms = ["Poker", "Ada Wong", "Fish", "Leon", "Rome"]; //项目经理
  Map<String, String> _selectedName = {"name": "Rome"};

  List<String> memberList = [
    "John Conner",
    "Peter Park",
    "Laura",
    "Morty",
    "Rick"
  ]; //成员
  Map<String, bool> members;

  @override
  void initState() {
    super.initState();
    members = new Map.fromEntries(memberList.map((v) => new MapEntry(v, false)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建项目"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "项目名称（必填）",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  expansionCallback: (index, isExpand) {},
                  children: <ExpansionPanelRadio>[
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text("项目经理"),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(_selectedName["name"]),
                            ),
                          ],
                        );
                      },
                      body: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Wrap(
                          spacing: 16,
                          children: MyCommonWidget.getChoiceChips(
                              pms, _selectedName, this),
                        ),
                      ),
                      value: 0,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text("项目成员"),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: MyCommonWidget.getTextFromMap(members),
                            ),
                          ],
                        );
                      },
                      body: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Wrap(
                          spacing: 16,
                          children: MyCommonWidget.getFilterChips(
                              memberList, members, this),
                        ),
                      ),
                      value: 1,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text("起讫日期:"),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(_time),
                            ),
                          ],
                        );
                      },
                      body: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            _time,
                            textScaleFactor: 1.4,
                          ),
                        ),
                        onTap: () async {
                          if (isFirstTime) {
                            startTime = await _showDatePicker1();
                            isFirstTime = false;
                            _time =
                                startTime.toString().split(" ")[0] + "  选择终止日期";
                          } else {
                            endTime = await _showDatePicker1(startTime);
                            _time = startTime.toString().split(" ")[0] +
                                " 到 " +
                                endTime.toString().split(" ")[0];
                            isFirstTime = true;
                          }
                          setState(() {});
                        },
                      ),
                      value: 3,
                    ),
                    ExpansionPanelRadio(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Text("管控型项目"),
                            ),
                            Spacer(),
                            Builder(
                              builder: (BuildContext context) {
                                return Switch(
                                  value: _withTree,
                                  onChanged: (bool value) {
                                    (context as Element).markNeedsBuild();
                                    _withTree = !_withTree;
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                      body: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text("打开后只有项目经理能修改项目中的任务"),
                      ),
                      value: 4,
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

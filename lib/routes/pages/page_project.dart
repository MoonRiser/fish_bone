import 'dart:collection';

import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_project.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fish_bone/common/network_api.dart';

class ProjectDisplayPage extends StatefulWidget {
  @override
  _ProjectCreatePageState createState() => _ProjectCreatePageState();
}

class _ProjectCreatePageState extends State<ProjectDisplayPage>
    with TickerProviderStateMixin {
  TabController controller;
  var tabs = <Widget>[
    Text('进行中'),
    Text('完成'),
    Text("全部"),
  ];
  int _index = 0;
  var _appBarColor;
  var projData = <int, List<Project>>{0: [], 1: [], 2: []};
  var projStatus = ["running", "finish", "all"];

  final ColorTween colorTween =
      new ColorTween(begin: Colors.blue, end: Colors.teal);

  @override
  void initState() {
    super.initState();
    controller = new TabController(initialIndex: 0, length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          _index = controller.index;
          //  print(_index);
        });
      });
    Animation animation = controller.animation;
    animation.addListener(() {
      //   print(animation.value);
      setState(() {
        _appBarColor = colorTween.evaluate(animation);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Center(child: _buildList()),
          Center(child: _buildList()),
          Center(child: _buildList()),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('展示项目'),
        backgroundColor: _appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.pushNamed(context, "projectCreate");
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: controller,
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget _buildList() {
    return InfiniteListView<Project>(
      onRetrieveData: (int page, List<Project> items, bool refresh) async {
        if (projData[_index].length > 0 && refresh == true) {
          projData[_index].clear();
        }

        //把请求到的新数据添加到items中
        var json =
            await Net().getProjList(page, 8, projStatus[_index], refresh);
        var jsonProj = json['list'] as List;
        var sublist = jsonProj.map((v) => Project.fromJson(v)).toList();
        projData[_index].addAll(sublist);
        items.addAll(sublist);
     //   print(items.length.toString() + ":" + sublist.length.toString());
        return (jsonProj.length > 0) && (jsonProj.length % 8 == 0);
        // return data.length > 0 && data.length % 5 == 0;
      },
      itemBuilder: (List list, int index, BuildContext context) {
        return GestureDetector(
          child: ProjectItemView(list[index]),
          onTap: () async {
            Navigator.of(context)
                .pushNamed("projectDetail", arguments: projData[_index][index]);
          },
        );
        // return
      },
    );
  }
}

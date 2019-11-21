import 'package:fish_bone/widgets/item_project.dart';
import 'package:flutter/material.dart';

class ProjectDisplayPage extends StatefulWidget {
  @override
  _ProjectCreatePageState createState() => _ProjectCreatePageState();
}

class _ProjectCreatePageState extends State<ProjectDisplayPage>
    with TickerProviderStateMixin {
  TabController controller;
  var tabs = <Widget>[Text('进行中'), Text('完成'), Text("全部"), Text("取消")];
  int _index = 0;
  var _appBarColor;

  final ColorTween colorTween =
      new ColorTween(begin: Colors.blue, end: Colors.teal);

  @override
  void initState() {
    super.initState();
    controller = new TabController(initialIndex: 0, length: 4, vsync: this)
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
          Center(
            child:ListView.builder(itemBuilder: (context,index){
              return ProjectItemView();
            },
            itemCount: 7,)
          ),
          Center(
            child: Text(_index.toString()),
          ),
          Center(
            child: Text(_index.toString()),
          ),
          Center(
            child: Text(_index.toString()),
          ),
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
}

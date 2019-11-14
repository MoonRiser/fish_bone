import 'package:fish_bone/routes/pages/page_notification.dart';
import 'package:fish_bone/routes/pages/page_task.dart';
import 'package:fish_bone/routes/pages/page_project.dart';
import 'package:fish_bone/routes/pages/page_worktable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FishBoneHome extends StatefulWidget {
  @override
  _FishBoneHomeState createState() => _FishBoneHomeState();
}

class _FishBoneHomeState extends State<FishBoneHome> {
  var pages = <Widget>[
    InfoRoute(),
    TaskDisplayPage(),
    ProjectDisplayPage(),
    SettingPage(),
  ];

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        fixedColor: Theme.of(context).accentColor,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('通知'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tag_solid),
            title: Text('待办任务'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list),
              title: Text('项目列表')),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('工作台'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:fish_bone/routes/arrange_work_page.dart';
import 'package:fish_bone/routes/notifi_page.dart';
import 'package:fish_bone/routes/to_do_page.dart';
import 'package:fish_bone/routes/work_table_page.dart';
import 'package:fish_bone/styles.dart';
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
    TaskCreatePage(),
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
            icon: Icon(CupertinoIcons.add_circled_solid),
            title: Text('安排工作'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tag_solid),
            title: Text('待办'),
          ),
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

import 'package:fish_bone/routes/create_project.dart';
import 'package:fish_bone/routes/create_task.dart';
import 'package:fish_bone/routes/detail_project.dart';
import 'package:fish_bone/routes/detail_task.dart';
import 'package:fish_bone/routes/home.dart';
import 'package:fish_bone/routes/login.dart';
import 'package:fish_bone/states/ui_state.dart';
import 'package:fish_bone/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';

void main() {
  Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIState>(
      builder: (context) => UIState(),
      child: Consumer<UIState>(
        builder: (context, state, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: Color.fromRGBO(238, 238, 245, 1.0),
                //   backgroundColor: Color.fromRGBO(238, 238, 245, 1.0),
                brightness: Brightness.light,
                primaryColor: Styles.colorPrimary,
                accentColor: Styles.colorAccent),
            darkTheme: ThemeData.dark(),
            themeMode: Provider.of<UIState>(context).themeMode,
            //  themeMode: ThemeMode.system,
            home: FishBoneHome(),
            initialRoute: "login",
            routes: <String, WidgetBuilder>{
              "login": (context) => LoginRoute(),
              "home": (context) => FishBoneHome(),
              "taskDetail": (context) =>
                  TaskDetail(ModalRoute.of(context).settings.arguments),
              "projectDetail": (context) => ProjectDetail(),
              "login": (context) => LoginRoute(),
              "taskCreate": (context) => TaskCreatePage(),
              "projectCreate": (context) => ProjectCreatePage(),
            },
          );
        },
      ),
    );
  }
}

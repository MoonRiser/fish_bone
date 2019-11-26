import 'package:fish_bone/models/bean.dart';
import 'package:flutter/material.dart';

class ProjectItemView extends StatelessWidget {
  final Project project;

  ProjectItemView(this.project);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          AlwaysStoppedAnimation(Theme.of(context).accentColor),
                      value: .7,
                    ),
                  ),
                  Text(project.percent),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      project.code ?? "null",
                      textScaleFactor: 0.8,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      project.name.length > 10
                          ? project.name.substring(0, 10)
                          : project.name,
                      textScaleFactor: 1.4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Text(
                    " ${project.startDate.split(" ")[0]}~${project.endDate.split(" ")[0]}"),
                Text("项目经理:${project.pm.name} "),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

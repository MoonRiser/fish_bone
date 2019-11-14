import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/styles.dart';
import 'package:flutter/material.dart';

class TaskItemView extends StatelessWidget {



  TaskItemView(this.taskBean);
  TaskBean taskBean;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                taskBean.taskName,
                textScaleFactor: 1.2,
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  taskBean.time,
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  taskBean.status,
                  style: TextStyle(
                      color: Styles.colorAccent, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

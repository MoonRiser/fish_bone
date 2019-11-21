import 'package:flutter/material.dart';

class ProjectItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("projectDetail");
      },
      child: Card(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Spacer(),
              Stack(
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
                  Text("70%"),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "XM2019001",
                        textScaleFactor: 0.8,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "鱼骨营销推广项目",
                        textScaleFactor: 1.4,
                      ),
                    ],
                  ),
                  Text(" 2016/02/25-2018/6/24"),
                  Text("项目经理：艾达王 "),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

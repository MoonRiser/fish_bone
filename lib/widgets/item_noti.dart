import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotiItem extends StatelessWidget {
  NotiItem(this.notifi);

  final Notifi notifi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Container(
                    height: 32,
                    width: 32,
                    color: Styles.randomColor(notifi.id),
                    child: Center(
                      child: Text(
                        notifi.userName.substring(0, 1), //以名字首字为头像
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1.4,
                      ),
                    )),
              ),
              Text(
                notifi.userName,
                textScaleFactor: 0.8,
              ),
            ],
          ),
          Expanded(
            flex: 1,
        //    child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  notifi.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
          //  ),
          ),
          Column(
            children: <Widget>[
              Text(
                notifi.subjectName,
                maxLines: 1,
              ),
              Text(
                notifi.date,
                style: TextStyle(color: Colors.grey),
                textScaleFactor: 0.8,
              )
            ],
          ),
        ],
      ),
    );
  }
}

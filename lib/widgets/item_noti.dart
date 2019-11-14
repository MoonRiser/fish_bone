import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotiItem extends StatelessWidget {
  NotiItem(this.notiBean);

  final NotiBean notiBean;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ClipOval(
                child: Container(
                    height: 40,
                    width: 40,
                    color: Styles.randomColor(),
                    child: Center(
                      child: Text(
                        notiBean.userName.substring(0, 1), //以名字首字为头像
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 2,
                      ),
                    )),
              ),
              Text(notiBean.userName),
              Spacer(
                flex: 1,
              ),
              Column(
                children: <Widget>[
                  Text(
                    notiBean.taskName,
                    maxLines: 1,
                  ),
                  Text(
                    notiBean.date,
                    style: TextStyle(color: Colors.grey),
                    textScaleFactor: 0.8,
                  )
                ],
              ),
            ],
          ),
          Text(
            notiBean.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

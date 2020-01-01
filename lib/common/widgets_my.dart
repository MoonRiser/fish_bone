import 'dart:math';
import 'package:fish_bone/models/bean.dart';
import 'package:flutter_custom_calendar/style/style.dart';
import 'package:fish_bone/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/model/date_model.dart';
import 'package:flutter_custom_calendar/widget/base_day_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'network_api.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    this.color = Colors.lightBlue,
    this.borderRadius = 24,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Color color;
  final double borderRadius;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius))),
      child: child,
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

/**
 * 这里定义成一个StatelessWidget，状态是外部的父控件传进来参数控制就行，自己不弄state类
 */

class MyCustomDayWidget extends BaseCustomDayWidget {
  const MyCustomDayWidget(DateModel dateModel) : super(dateModel);

  @override
  void drawNormal(DateModel dateModel, Canvas canvas, Size size) {
    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
        text: dateModel.day.toString(),
        style: dateModel.isCurrentDay
            ? currentDayTextStyle
            : (dateModel.isCurrentMonth
                ? currentMonthTextStyle
                : notCurrentMonthTextStyle),
      )
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.start;

    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, 10));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(text: dateModel.lunarString, style: lunarTextStyle)
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.start;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));

    //下面的文字
    TextPainter numTextPainter = new TextPainter()
      ..text = new TextSpan(text: "15", style: TextStyle(color: Colors.blue))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.start;

    numTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    numTextPainter.paint(canvas, Offset(size.width / 2 - 5, 14));
  }

  @override
  void drawSelected(DateModel dateModel, Canvas canvas, Size size) {
    //绘制背景
    Paint backGroundPaint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    double padding = 8;
    canvas.drawRect(
        Rect.fromPoints(Offset(padding, padding),
            Offset(size.width - padding, size.height - padding)),
        backGroundPaint);

    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text =
          TextSpan(text: dateModel.day.toString(), style: currentMonthTextStyle)
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, 10));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(text: dateModel.lunarString, style: lunarTextStyle)
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));
  }
}

class MyCommonWidget {
  NotiCallback callback;

  static List<Widget> getChoiceChips(
      List<String> _materials, Map<String, String> _selectedName, State state) {
    return _materials.map<Widget>((String name) {
      return ChoiceChip(
        key: ValueKey<String>(name),
        backgroundColor: Styles.getColorByString(name),
        label: Text(name),
        pressElevation: 0,
        selected: _selectedName['name'] == name,
        onSelected: (bool value) {
          _selectedName['name'] = value ? name : '';
          state.setState(() {});
        },
      );
    }).toList();
  }

  static List<Widget> getFilterChips(
      List<String> _materials, Map<String, bool> cc, State state) {
    return _materials.map<Widget>((String name) {
      return FilterChip(
        key: ValueKey<String>(name),
        backgroundColor: Styles.getColorByString(name),
        label: Text(name),
        pressElevation: 0,
        selected: cc[name],
        onSelected: (bool value) {
          cc[name] = value;
          state.setState(() {});
        },
      );
    }).toList();
  }

  Widget getHeader(
      TextEditingController controller,
      FocusNode focus,
      ScrollController scrollController,
      BuildContext context,
      NotiCallback callback) {
    this.callback = callback;
    var header = Column(
      children: <Widget>[
        Container(
          height: 12,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).textTheme.title.color),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  "评论",
                  textScaleFactor: 1.4,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  focusNode: focus
                    ..addListener(() {
                      if (focus.hasFocus) {
                        scrollController.jumpTo(0.0);
                      }
                    }),
                  decoration:
                      InputDecoration(filled: true, border: InputBorder.none),
                  controller: controller,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (controller.text.trim().length < 1) return;
                    String msg = await callback.setNotiData();
                    if (msg == "评论成功") {
                      controller.clear();
                      scrollController.jumpTo(0.0);
                      callback.getNotiData();
                    } else {
                      Fluttertoast.showToast(
                          msg: "评论失败", gravity: ToastGravity.CENTER);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return header;
  }

  static Widget getTextFromMap(Map<String, bool> map) {
    var temp = '';
    map.forEach((k, v) {
      if (v) {
        temp = temp + k + "、";
      }
    });
    return Text(temp);
  }

  static String getPeopleName(List<User> list) {
    switch (list.length) {
      case 0:
        return "";
      case 1:
        return "${list[0].name}";
      case 2:
        return "${list[0].name}\\${list[1].name}";
    }

    return "${list[0].name}\\${list[1].name}...";
  }
}

typedef GetNotiData = Future Function();
typedef SetNotiData = Future<String> Function();

//回调接口
class NotiCallback {
  GetNotiData getNotiData;
  SetNotiData setNotiData;

  NotiCallback(this.getNotiData, this.setNotiData);
}

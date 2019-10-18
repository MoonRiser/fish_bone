import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const CupertinoThemeData DayTheme =
      CupertinoThemeData(brightness: Brightness.light);

  static const CupertinoThemeData NightTheme =
      CupertinoThemeData(brightness: Brightness.dark);

  static const Color colorPrimary = Colors.blue;
  static const Color colorPrimaryDark = Colors.blueAccent;
  static const Color colorAccent = Colors.pink;
  static const Color colorPrimaryLight = Colors.pinkAccent;

  static const Color primaryText = Color(0xff212121);
  static const Color secondaryText = Color(0xff757575);

  static const Color dividerColor = Color(0xffBDBDBD);

  static const TextStyle productRowItemPrice = TextStyle(
    //  color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle searchText = TextStyle(
    //  color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle deliveryTimeLabel = TextStyle(
    //   color: Color(0xFFC2C2C2),
    fontWeight: FontWeight.w300,
  );

  static const TextStyle deliveryTime = TextStyle(
    color: CupertinoColors.inactiveGray,
  );

  static const BoxShadow cardShadow =
      BoxShadow(offset: Offset(0, 0), color: Colors.black54, blurRadius: 4.0);

  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(8));

  static Widget getLongButton(
      {String label, bool isEnable, Function callback, BuildContext context}) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 48.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(label),
        disabledElevation: 0,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.blueGrey,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: isEnable ? callback : null,
      ),
    );
    /*
      Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: RaisedButton(
              child: Text(label),
              disabledElevation: 0,
              disabledColor: Colors.grey,
              color: Styles.colorPrimary,
              disabledTextColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: !isEnable ? null : callback,
            ))
      ],
    );
    */
  }

  static Color randomColor() {
    var colors = [
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.green,
    ];
    var random = new Random();
    return colors[random.nextInt(5)];
  }
}

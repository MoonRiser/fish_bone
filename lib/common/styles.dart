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

  static const BoxShadow cardShadow =
      BoxShadow(offset: Offset(0, 0), color: Colors.black54, blurRadius: 4.0);

  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(8));

  static Widget getLongButton(
      {String label, bool isEnable, Function callback, BuildContext context}) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 48.0),
      child: RaisedButton(
        color: Colors.blueAccent,
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

  static Color randomColor([int seed]) {
    var colors = [
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.green,
    ];
    var random = new Random(seed);
    return colors[random.nextInt(5)];
  }

  // This converts a String to a unique color, based on the hash value of the
  // String object.  It takes the bottom 16 bits of the hash, and uses that to
  // pick a hue for an HSV color, and then creates the color (with a preset
  // saturation and value).  This means that any unique strings will also have
  // unique colors, but they'll all be readable, since they have the same
  // saturation and value.
  static Color getColorByString(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}

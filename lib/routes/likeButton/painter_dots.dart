import 'dart:math';
import 'package:flutter/cupertino.dart';

class DotsPainter extends CustomPainter {
  final double angle = 2 * pi / 7;
  final Color _color;
  final double _progress;

  final Paint mPaint = new Paint();

  DotsPainter(this._color, this._progress) {
    mPaint
      ..color = _color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_progress == 1.0 || _progress == 0.6) return;

    Offset center = Offset(size.width / 2, size.height / 2);
    double ang;
    Offset cen;
    double _radius = _progress * size.width / 2;
    //canvas.saveLayer(Offset.zero & size, Paint());
    for (var i = 0; i < 7; i++) {
      ang = i * angle;
      cen = Offset(
          center.dx + _radius * cos(ang), center.dy - _radius * sin(ang));
      canvas.drawCircle(cen, 2, mPaint);
    }
    //canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

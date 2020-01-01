import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CirclePainter extends CustomPainter {
  final double _progress;
  final Color _color;

  Paint mPaint = new Paint();

  CirclePainter(this._progress, this._color) {
    mPaint
      ..color = this._color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_progress == 1.0) return;
    var center = size.width / 2;
    // canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawCircle(Offset(center, center), center * _progress, mPaint);
    //   canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

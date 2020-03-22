import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Animation<double> _animation;

  // notify repaint listener during animation lifecycle
  CirclePainter(this._animation) : super(repaint: _animation);

  void _circle(Canvas canvas, Size size, double value) {
    var paint = Paint()
      ..color = Colors.green.withOpacity((1.0 - (value / 4.0)).clamp(0.0, 1.0));
    double radius = value * 40;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double waves = 3; waves >= 0; waves--) {
      // compute from animation value that ranges from 0.0 to 1.0 during a given duration to produce pulse effect
      _circle(canvas, size, waves + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

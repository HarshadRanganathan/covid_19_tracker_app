import 'package:flutter/material.dart';
import './info_content.dart';
import '../animation/circle_painter.dart';

class InfoCircle extends StatelessWidget {
  final Animation<double> animation;
  final String title;
  final String count;

  InfoCircle(
      {@required this.animation, @required this.title, @required this.count});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(animation),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        constraints: BoxConstraints.expand(
          height: 180.0,
          width: 180.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InfoContent(content: title),
            SizedBox(
              height: 5,
            ),
            InfoContent(content: count),
          ],
        ),
      ),
    );
  }
}

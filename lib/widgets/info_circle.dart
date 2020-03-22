import 'dart:ffi';

import 'package:flutter/material.dart';

class InfoCircle extends StatelessWidget {
  final String title;
  final int count;

  InfoCircle({@required this.title, @required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 5)),
      constraints: BoxConstraints.expand(height: 180.0, width: 180.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            count.toString(),
            style: TextStyle(color: Colors.green, fontSize: 18),
          )
        ],
      ),
    );
  }
}

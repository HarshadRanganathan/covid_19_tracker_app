import 'package:flutter/material.dart';

class InfoContent extends StatelessWidget {
  final String content;

  InfoContent({@required this.content});

  Widget textWidget(String content) {
    return Text(
      content,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textWidget(content);
  }
}

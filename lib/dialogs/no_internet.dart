import 'package:flutter/material.dart';

Future<void> showNoInternetDialog(BuildContext context, Function callback) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('No Internet Connection'),
        content: Text(
            'Active internet connection is required to retrieve Covid-19 data'),
        actions: <Widget>[
          FlatButton(
            child: Text('Proceed'),
            onPressed: () {
              Navigator.of(context).pop();
              callback(context);
            },
          )
        ],
      );
    },
  );
}

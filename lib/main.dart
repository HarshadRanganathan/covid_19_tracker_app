import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import './widgets/info_circle.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Tracker',
      theme: ThemeData(primarySwatch: Colors.green),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Tracker'),
      ),
      body: _Stats()
    );
  }
}

class _Stats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatsState();
  }
}

class _StatsState extends State<_Stats> {

  int _globalRecoveries;

  @override
  void initState() {
    super.initState();
    _getLatestData();
  }

  void _getLatestData() async {
    const url = 'https://coronavirus-tracker-api.herokuapp.com/v2/latest';
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        _globalRecoveries = jsonResponse['latest']['recovered'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: InfoCircle(
              title: 'Total Recoveries',
              count: _globalRecoveries,
            )
          )
        ],
      );
  }
}

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../widgets/locations_dropdown.dart';
import '../widgets/info_circle.dart';

class Stats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatsState();
  }
}

class _StatsState extends State<Stats> with SingleTickerProviderStateMixin {
  String _recoveries = 'NA';
  AnimationController _controller;
  Map<String, int> _locationData = Map<String, int>();
  var _countFormatter = NumberFormat.compact(locale: 'en');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _startAnimation();
    _getLocationsData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    TickerFuture tickerFuture = _controller.repeat(
      period: Duration(seconds: 1),
    );
    tickerFuture.timeout(Duration(seconds: 15), onTimeout: () {
      _controller.stop();
    });
  }

  void _setRecoveries(String country) {
    String count = _countFormatter.format(_locationData[country]);
    _startAnimation();
    setState(() {
      _recoveries = count;
    });
  }

  void _getLocationsData() async {
    const url = 'https://coronavirus-tracker-api.herokuapp.com/v2/locations';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      jsonResponse['locations'].forEach((location) =>
          _locationData[location['country']] = location['latest']['recovered']);
      _locationData['World'] = jsonResponse['latest']['recovered'];
      setState(() {
        _recoveries =
            _countFormatter.format(jsonResponse['latest']['recovered']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom:50.0),
          child: LocationsDropdown(
            countries: _locationData.keys,
            callback: _setRecoveries,
          ),
        ),
        Container(
          child: Center(
            child: InfoCircle(
              animation: _controller,
              title: 'Total Recoveries',
              count: _recoveries,
            ),
          ),
        ),
      ],
    );
  }
}

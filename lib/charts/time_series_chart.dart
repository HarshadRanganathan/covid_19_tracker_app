import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../model/time_series_recovered.dart';

class TimeSeriesChart extends StatelessWidget {

  final List<charts.Series<TimeSeriesRecovered, DateTime>> data;

  TimeSeriesChart(this.data);

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      data,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

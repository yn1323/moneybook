// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartData {
  final String domain;
  final int price;
  PieChartData(this.domain, this.price);
}

class PieChart extends StatelessWidget {
  final List<charts.Series<PieChartData, int>> seriesList;
  final bool animate;

  const PieChart(this.seriesList, {this.animate = true});

  factory PieChart.render({required List<PieChartData> data}) {
    return PieChart(createPieChartData(data));
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<int>(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 140,
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );
  }

  static List<charts.Series<PieChartData, int>> createPieChartData(
      List<PieChartData> data) {
    return [
      charts.Series<PieChartData, int>(
        id: 'main',
        domainFn: (PieChartData d, _) => _ ?? 0,
        measureFn: (PieChartData d, _) => d.price,
        data: data,
        labelAccessorFn: (PieChartData d, _) => '${d.domain}: ${d.price}',
      )
    ];
  }
}

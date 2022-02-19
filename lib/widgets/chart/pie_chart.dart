// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:moneybook/models/currency.dart';
import 'package:moneybook/src/helper/string.dart';

final defaultColor = charts.ColorUtil.fromDartColor(Colors.amber);

class PieChartData {
  final String domain;
  final int number;
  final MaterialColor theme;
  final Currency currency;
  charts.Color? color;
  String label = '';

  PieChartData(
      {required this.domain,
      required this.number,
      required this.currency,
      this.theme = Colors.amber}) {
    color = charts.ColorUtil.fromDartColor(theme[300]!);
    final prefix = currency.isPrefix ? currency.currency : '';
    final suffix = currency.isSuffix ? currency.currency : '';
    label = '$prefix${addComma(number)}$suffix';
  }
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
        // arcWidth: 140,
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
        measureFn: (PieChartData d, _) => d.number,
        data: data,
        labelAccessorFn: (PieChartData d, _) => '${d.domain}\n${d.label}',
        colorFn: (PieChartData d, _) => d.color ?? defaultColor,
      )
    ];
  }
}

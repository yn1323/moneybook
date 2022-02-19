import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class ChartYearly extends ConsumerStatefulWidget {
  const ChartYearly({
    Key? key,
  }) : super(key: key);

  @override
  _ChartYearly createState() => _ChartYearly();
}

class _ChartYearly extends ConsumerState<ChartYearly> {
  @override
  Widget build(BuildContext context) {
    final data = [
      PieChartData(domain: 'aaa', number: 5),
    ];
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: PieChart.render(data: data),
    );
  }
}

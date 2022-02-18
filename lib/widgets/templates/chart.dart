import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class Chart extends ConsumerStatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  _Chart createState() => _Chart();
}

class _Chart extends ConsumerState<Chart> {
  @override
  Widget build(BuildContext context) {
    final data = [
      PieChartData('aaa', 5),
    ];

    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: PieChart.render(data: data),
    );
  }
}

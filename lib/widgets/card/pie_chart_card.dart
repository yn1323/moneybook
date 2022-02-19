import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class PieChartCard extends ConsumerStatefulWidget {
  const PieChartCard({Key? key, required this.data}) : super(key: key);

  final List<PieChartData> data;

  @override
  _PieChartCard createState() => _PieChartCard();
}

class _PieChartCard extends ConsumerState<PieChartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 300,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PieChart.render(data: widget.data),
        ),
      ),
    );
  }
}

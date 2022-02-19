import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class ChartDetailCard extends HookConsumerWidget {
  const ChartDetailCard({Key? key, required this.data}) : super(key: key);
  final List<PieChartData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data.any((element) => element.domain == '')) {
      return Container();
    }
    return Column(
      children: data
          .map(
            (e) => Card(
              elevation: 2,
              color: e.theme[200],
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(e.domain),
                    Text(e.label),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

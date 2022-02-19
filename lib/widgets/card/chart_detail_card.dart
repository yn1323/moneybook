import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class ChartDetailCard extends HookConsumerWidget {
  const ChartDetailCard({Key? key, required this.data}) : super(key: key);
  final List<PieChartData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = deviceHeight - padding.top - padding.bottom;

    if (data.any((element) => element.domain == '')) {
      return Container();
    }
    return SizedBox(
      height: height1 - 544,
      child: ListView(
        children: data
            .map(
              (e) => Container(
                color: e.theme[100],
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.domain),
                        Text(e.label),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

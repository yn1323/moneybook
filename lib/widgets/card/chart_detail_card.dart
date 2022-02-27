import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';
import 'package:moneybook/widgets/text/text_with_icon.dart';

class ChartDetailCard extends HookConsumerWidget {
  const ChartDetailCard({Key? key, required this.data}) : super(key: key);
  final List<PieChartData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    // Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = deviceHeight - padding.top - padding.bottom;

    if (data.every((element) => element.domain == '')) {
      return Container();
    }
    return SizedBox(
      height: height1 - 555,
      child: ListView(
        children: data
            .map(
              (e) => SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithIcon(
                        fillColor: e.theme,
                        icon: e.icon,
                        text: e.domain,
                      ),
                      Text(e.label),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

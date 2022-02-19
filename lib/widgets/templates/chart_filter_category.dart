import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/monthly_cash_in_chart.dart';
import 'package:moneybook/providers/fragments/total_price.dart';
import 'package:moneybook/themes/chart.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class ChartFilterCategory extends ConsumerStatefulWidget {
  const ChartFilterCategory({
    Key? key,
  }) : super(key: key);

  @override
  _ChartFilterCategory createState() => _ChartFilterCategory();
}

class _ChartFilterCategory extends ConsumerState<ChartFilterCategory> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(monthlyCashInChart('category'));
    final currency = ref.watch(currencyProvider);
    final price = ref.watch(totalPrice);
    final data = list
        .map((e) => PieChartData(
            currency: currency,
            domain: e.domain,
            number: e.number,
            theme: chartTheme[list.indexOf(e)]))
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[const Text('合計'), Text(price)],
          ),
        ),
        Card(
          elevation: 0,
          child: SizedBox(
            height: 300,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PieChart.render(data: data),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/monthly_cash_by_category.dart';
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
    final list = ref.watch(monthlyCashByCategory);
    final currency = ref.watch(currencyProvider);
    final data = list
        .map((e) => PieChartData(
            currency: currency,
            domain: e.categoryName,
            number: e.price,
            theme: chartTheme[list.indexOf(e)]))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PieChart.render(data: data),
    );
  }
}

import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/monthly_cash_in_chart.dart';
import 'package:moneybook/themes/chart.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';

class ChartFilterMember extends ConsumerStatefulWidget {
  const ChartFilterMember({
    Key? key,
  }) : super(key: key);

  @override
  _ChartFilterMember createState() => _ChartFilterMember();
}

class _ChartFilterMember extends ConsumerState<ChartFilterMember> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(monthlyCashInChart('member'));
    final currency = ref.watch(currencyProvider);
    final data = list
        .map((e) => PieChartData(
            currency: currency,
            domain: e.domain,
            number: e.number,
            theme: chartTheme[list.indexOf(e)]))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PieChart.render(data: data),
    );
  }
}

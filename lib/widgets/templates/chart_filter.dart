import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/monthly_cash_in_chart.dart';
import 'package:moneybook/themes/chart.dart';
import 'package:moneybook/widgets/card/pie_chart_card.dart';
import 'package:moneybook/widgets/chart/pie_chart.dart';
import 'package:moneybook/widgets/header/total_price.dart';

class ChartFilter extends ConsumerStatefulWidget {
  const ChartFilter({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  _ChartFilter createState() => _ChartFilter();
}

class _ChartFilter extends ConsumerState<ChartFilter> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(monthlyCashInChart(widget.type));
    final currency = ref.watch(currencyProvider);
    final data = list
        .map((e) => PieChartData(
            currency: currency,
            domain: e.domain,
            number: e.number,
            theme: chartTheme[list.indexOf(e)]))
        .toList();

    return Column(
      children: [
        const TotalPrice(),
        PieChartCard(data: data),
      ],
    );
  }
}

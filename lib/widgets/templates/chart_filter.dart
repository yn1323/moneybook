import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/fragments/monthly_cash_in_chart.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/themes/chart.dart';
import 'package:moneybook/widgets/card/chart_detail_card.dart';
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
  List<Color> getMemberColor(List<ChartDataum> list) {
    final r = ref.read(memberProvider.notifier);
    return list.map((e) => r.findByLabel(e.domain).color).toList();
  }

  List<Color> getCategoryColor(List<ChartDataum> list) {
    final r = ref.read(categoryProvider.notifier);
    return list.map((e) => r.findByLabel(e.domain).color).toList();
  }

  List<IconData> getMemberIcon(List<ChartDataum> list) {
    final r = ref.read(memberProvider.notifier);
    return list.map((e) => r.findByLabel(e.domain).icon).toList();
  }

  List<IconData> getCategoryIcon(List<ChartDataum> list) {
    final r = ref.read(categoryProvider.notifier);
    return list.map((e) => r.findByLabel(e.domain).icon).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMember = widget.type == 'member';
    final list = ref.watch(monthlyCashInChart(widget.type));
    final color = isMember ? getMemberColor(list) : getCategoryColor(list);
    final icon = isMember ? getMemberIcon(list) : getCategoryIcon(list);
    final currency = ref.watch(currencyProvider);
    final data = list
        .map((e) => PieChartData(
              currency: currency,
              domain: e.domain,
              number: e.number,
              theme: color[list.indexOf(e)] as MaterialColor,
              icon: icon[list.indexOf(e)],
            ))
        .toList();

    return Column(
      children: [
        const TotalPrice(),
        PieChartCard(data: data),
        ChartDetailCard(data: data),
      ],
    );
  }
}

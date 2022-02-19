import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/fragments/monthly_cash_by_member.dart';
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
    final list = ref.watch(monthlyCashByMember);
    final data = list
        .map((e) => PieChartData(domain: e.memberName, number: e.price))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PieChart.render(data: data),
    );
  }
}

import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/fragments/monthly_cash_list.dart';
import 'package:moneybook/widgets/card/budget_card.dart';
import 'package:moneybook/widgets/card/cash_card.dart';

class ListCash extends ConsumerStatefulWidget {
  const ListCash({
    Key? key,
  }) : super(key: key);

  @override
  _ListCash createState() => _ListCash();
}

class _ListCash extends ConsumerState<ListCash> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(monthlyCashList);
    final bool hasList = list.isNotEmpty;

    return SingleChildScrollView(
      child: Column(
        children: [
          const BudgetCard(),
          if (!hasList)
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('No Data'),
            ),
          ...list.map((e) => CardCash(cash: e)),
        ],
      ),
    );
  }
}

import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/fragments/monthly_cash_list.dart';
import 'package:moneybook/providers/fragments/total_price.dart';
import 'package:moneybook/widgets/card/budget_card.dart';
import 'package:moneybook/widgets/card/cash_card.dart';
import 'package:moneybook/widgets/dialog/color_picker_dialog.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

    return SingleChildScrollView(
      child: Column(
        children: [
          const BudgetCard(),
          ...list.map((e) => CardCash(cash: e)),
          ColorPickerDialog(
            callback: (c) {},
            defaultColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

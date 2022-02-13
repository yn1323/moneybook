import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/fragments/monthly_cash_list.dart';
import 'package:moneybook/providers/fragments/total_price.dart';

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
    final price = ref.watch(totalPrice);
    final m = ref.watch(monthlyCashList);
    print(price);

    ref.read(cashProvider.notifier).fetch(year: 2022, month: 2);

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[const Text('合計'), Text(price)],
          ),
        )
      ],
    );
  }
}

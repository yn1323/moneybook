import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/src/helper/string.dart';

class CardCash extends ConsumerStatefulWidget {
  const CardCash({Key? key, required this.cash}) : super(key: key);

  final Cash cash;

  @override
  _CardCash createState() => _CardCash();
}

class _CardCash extends ConsumerState<CardCash> {
  String addCurrency(int price) {
    return ref.read(currencyProvider.notifier).joinCurrency(price);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 1.5,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dateToString(date: widget.cash.date)),
                  Text(widget.cash.category),
                  Text(addCurrency(widget.cash.price)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

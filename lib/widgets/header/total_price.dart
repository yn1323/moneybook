import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/fragments/total_price.dart';

class TotalPrice extends ConsumerStatefulWidget {
  const TotalPrice({
    Key? key,
  }) : super(key: key);

  @override
  _TotalPrice createState() => _TotalPrice();
}

class _TotalPrice extends ConsumerState<TotalPrice> {
  @override
  Widget build(BuildContext context) {
    final price = ref.watch(totalPrice(null)).priceStr;

    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[const Text('合計'), Text(price)],
      ),
    );
  }
}

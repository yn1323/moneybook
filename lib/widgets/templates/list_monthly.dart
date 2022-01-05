import 'package:moneybook/imports.dart';

class ListMonthly extends ConsumerStatefulWidget {
  const ListMonthly({
    Key? key,
  }) : super(key: key);

  @override
  _ListMonthly createState() => _ListMonthly();
}

class _ListMonthly extends ConsumerState<ListMonthly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('list monthly'),
    );
  }
}

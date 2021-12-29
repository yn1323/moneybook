import 'package:moneybook/imports.dart';

class ListWeekly extends ConsumerStatefulWidget {
  const ListWeekly({
    Key? key,
  }) : super(key: key);

  @override
  _ListWeekly createState() => _ListWeekly();
}

class _ListWeekly extends ConsumerState<ListWeekly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('list weekly'),
    );
  }
}

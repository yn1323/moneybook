import 'package:moneybook/imports.dart';

class ListDaily extends ConsumerStatefulWidget {
  const ListDaily({
    Key? key,
  }) : super(key: key);

  @override
  _ListDaily createState() => _ListDaily();
}

class _ListDaily extends ConsumerState<ListDaily> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('list weekly'),
    );
  }
}

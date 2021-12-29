import 'package:moneybook/imports.dart';

class Chart extends ConsumerStatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  _Chart createState() => _Chart();
}

class _Chart extends ConsumerState<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('chart'),
    );
  }
}

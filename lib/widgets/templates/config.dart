import 'package:moneybook/imports.dart';

class Config extends ConsumerStatefulWidget {
  const Config({
    Key? key,
  }) : super(key: key);

  @override
  _Config createState() => _Config();
}

class _Config extends ConsumerState<Config> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('config'));
  }
}

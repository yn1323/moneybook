import 'package:moneybook/imports.dart';

class ConfigId extends ConsumerStatefulWidget {
  const ConfigId({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigId createState() => _ConfigId();
}

class _ConfigId extends ConsumerState<ConfigId> {
  final String title = '共有ID設定';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

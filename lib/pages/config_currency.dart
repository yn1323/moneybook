import 'package:moneybook/imports.dart';

class ConfigCurrency extends ConsumerStatefulWidget {
  const ConfigCurrency({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigCurrency createState() => _ConfigCurrency();
}

class _ConfigCurrency extends ConsumerState<ConfigCurrency> {
  final String title = '通貨設定';
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

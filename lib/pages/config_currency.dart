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
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  bool currencyIsPrefix = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      maxLength: 3,
                      controller: controller,
                      decoration: const InputDecoration(labelText: '通貨の単位'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '通貨単位を入力してください。';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: SwitchListTile(
                      value: currencyIsPrefix,
                      title: const Text('通貨表示位置'),
                      onChanged: (next) {
                        setState(() => currencyIsPrefix = next);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              print(controller.text);
                              print(currencyIsPrefix);
                            }
                          },
                          child: const Text('変更'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
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
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'IDを揃えることで他の人と家計簿を共有できます。',
              style: TextStyle(fontSize: 14),
            ),
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    focusNode: focusNode,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'IDを入力してください。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.text = 'initial Id';
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary),
                          child: const Text('初期IDに戻す'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              print(controller.text);
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

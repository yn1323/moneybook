import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';

class CategoryNew extends ConsumerStatefulWidget {
  const CategoryNew({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryNew createState() => _CategoryNew();
}

class _CategoryNew extends ConsumerState<CategoryNew> {
  final title = '新規カテゴリー追加';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void add(String addItem) {
    ref.read(categoryProvider.notifier).add(addItem);
  }

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
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLength: 16,
                    focusNode: focusNode,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'カテゴリー'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'カテゴリーを入力してください。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              add(controller.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('新規追加'),
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

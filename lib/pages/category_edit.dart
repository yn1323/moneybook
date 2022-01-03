import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';

class CategoryEdit extends ConsumerStatefulWidget {
  const CategoryEdit({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryEdit createState() => _CategoryEdit();
}

class _CategoryEdit extends ConsumerState<CategoryEdit> {
  final title = 'カテゴリー編集';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void edit({int index = 0, String nextCategory = ''}) {
    ref
        .read(categoryProvider.notifier)
        .edit(index: index, nextCategory: nextCategory);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final index = args['index'] as int;
    final category = args['category'] as String;
    controller.text = category;

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
                              edit(index: index, nextCategory: controller.text);
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

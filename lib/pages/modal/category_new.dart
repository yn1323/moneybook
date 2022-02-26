import 'package:moneybook/constants/index.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/widgets/form/icon_selector.dart';

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
  IconData icon = Icons.ac_unit;
  Color color = Colors.blue;

  void add(String addItem) {
    ref.read(categoryProvider.notifier).add(addItem);
  }

  void iconSetter(IconData i) {
    setState(() {
      icon = i;
    });
  }

  void colorSetter(Color c) {
    setState(() {
      color = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = ref.watch(categoryProvider);
    final isMax = currentCategory.length >= maxCategoryNum;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconSelector(
                    icon: icon,
                    color: color,
                    iconSetter: iconSetter,
                    colorSetter: colorSetter,
                  ),
                  TextFormField(
                    maxLength: 16,
                    focusNode: focusNode,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'カテゴリー'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'カテゴリーを入力してください。';
                      }
                      if (isMax) {
                        return 'カテゴリー数が最大です。\n既にあるカテゴリーを削除してください。';
                      }
                      if (currentCategory.contains(value)) {
                        return '同名のカテゴリーが既に存在しています。';
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

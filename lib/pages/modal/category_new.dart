import 'package:moneybook/constants/index.dart';
import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/src/helper/constant/color.dart';
import 'package:moneybook/src/helper/constant/icon.dart';
import 'package:moneybook/widgets/form/icon_selector.dart';

class CategoryNew extends ConsumerStatefulWidget {
  const CategoryNew({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryNew createState() => _CategoryNew();
}

class _CategoryNew extends ConsumerState<CategoryNew> {
  final title = 'カテゴリー';
  final _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  IconData icon = randomIcon();
  Color color = randomColor();
  bool isExecuted = false;
  int index = 0;

  void setInitialVal(int i) {
    if (isExecuted) {
      return;
    }
    Category category = ref.read(categoryProvider)[i];
    controller.text = category.label;

    setState(() {
      icon = category.icon;
      color = category.color;
      isExecuted = true;
      index = i;
    });
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

  void add(String addItem) {
    ref.read(categoryProvider.notifier).add(
          Category(label: addItem, icon: icon, color: color),
        );
  }

  void edit({required int index, required String label}) {
    ref.read(categoryProvider.notifier).edit(
          index: index,
          nextCategory: Category(label: label, icon: icon, color: color),
        );
  }

  void delete(int index) {
    ref.read(categoryProvider.notifier).delete(index);
  }

  void deleteConfirm(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('本当に削除しますか？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              delete(index);
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = ref.watch(categoryProvider);
    final isMax = currentCategory.length >= maxCategoryNum;
    final isEdit = ModalRoute.of(context)?.settings.name == '/category/edit';

    if (isEdit) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final i = args['index'] as int;
      setInitialVal(i);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                      if (!isEdit && isMax) {
                        return 'カテゴリー数が最大です。\n既にあるカテゴリーを削除してください。';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: isEdit
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (isEdit)
                          ElevatedButton(
                            onPressed: () => deleteConfirm(index),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                            ),
                            child: const Text('削除'),
                          ),
                        if (isEdit)
                          ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                edit(index: index, label: controller.text);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('変更'),
                          ),
                        if (!isEdit)
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

import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/filter.dart';
import 'package:moneybook/widgets/form/category_selector.dart';
import 'package:moneybook/widgets/form/member_selecter.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  _Filter createState() => _Filter();
}

class _Filter extends ConsumerState<Filter> {
  final String title = 'フィルター';
  final _key = GlobalKey<FormState>();
  final TextEditingController categoryController =
      TextEditingController(text: '');
  final TextEditingController memberController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    memberController.text = ref.read(filterProvider).member;
    categoryController.text = ref.read(filterProvider).category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemberSelecter(controller: memberController),
                  CategorySelecter(controller: categoryController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_key.currentState!.validate()) {
                              ref.read(filterProvider.notifier).setFilter(
                                  categoryController.text,
                                  memberController.text);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('保存'),
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

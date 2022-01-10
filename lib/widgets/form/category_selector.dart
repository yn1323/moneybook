import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';

class CategorySelecter extends ConsumerStatefulWidget {
  const CategorySelecter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  @override
  _CategorySelecter createState() => _CategorySelecter();
}

class _CategorySelecter extends ConsumerState<CategorySelecter> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.read(categoryProvider).getCategory();
    return GestureDetector(
      onTap: () async {
        String? result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: categories
                  .map(
                    (member) => ListTile(
                      title: Text(member),
                      onTap: () => Navigator.of(context).pop(member),
                    ),
                  )
                  .toList(),
            );
          },
        );
        if (result != null) {
          widget.controller.text = result;
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'カテゴリー',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'カテゴリーを入力してください。';
            }
            return null;
          },
        ),
      ),
    );
  }
}

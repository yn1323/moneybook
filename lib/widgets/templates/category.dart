import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';

class Category extends ConsumerStatefulWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends ConsumerState<Category> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider).category;
    return ReorderableListView(
      children: categories
          .map(
            (category) => ListTile(
              key: Key(category),
              title: Text(category),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/category/edit');
                      },
                      icon: const Icon(Icons.edit)),
                  ReorderableDragStartListener(
                    index: categories.indexOf(category),
                    child: const Icon(Icons.drag_handle),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onReorder: (int prev, int next) {
        ref.read(categoryProvider.notifier).reorder(prev, next);
      },
    );
  }
}
